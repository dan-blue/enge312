#import "@preview/zap:0.5.0"

// CIRCUIT 1: CE Amplifier with Resistor Biasing
#let ce_resistor_biasing() = {
  zap.circuit({
      import zap: *
      set-style(variant: "ieee")
      
      // Central NPN Transistor Q1
      bjt("Q1", (-2, 0), polarisation: "npn", label: "Q1\n2N3904")
      
      // Input Section
      node("bjt", (-5, 0))
      wire("bjt", "Q1.b")
      node("Vi", (-10, 0), label: $V_i$)
      capacitor("C1", "Vi", "bjt", label: "C1\n1µF")
      
      // Voltage Divider Biasing
      vcc("Vcc1", (-5, 3), label: "15V")
      resistor("R1", "Vcc1", "bjt", label: "R1 47kΩ")
      resistor("R2", "bjt", (-5, -3), label: "R2 33kΩ")
      earth("G1", (-5, -3))
      
      // Collector Branch
      node("Cj", (-2, 1.2))
      wire("Cj", "Q1.c")
      resistor("Rc", (-2, 3), "Cj", label: "RC 2.2kΩ")
      wire((-5, 3), (-2, 3))
      
      // Emitter Branch
      node("Ej", (-2, -1.2))
      wire("Q1.e", "Ej")
      resistor("Re", "Ej", (-2, -3), label: "RE 1.8kΩ")
      earth("G2", (-2, -3))
      
      // Emitter Bypass Capacitor
      wire("Ej", (1, -1.2))
      capacitor("Ce", (1, -1.2), (1, -3), label: "CE\n10µF")
      earth("G4", (1, -3))
      
      // Output Section
      wire((-2, 1.2), (0, 1.2))
      capacitor("C2", (0, 1.2), (3.5, 1.2), label: "C2\n1µF")
      node("Vo_junc", (3.5, 1.2))
      resistor("RL", "Vo_junc", (3.5, -3), label: "RL 2.2kΩ")
      earth("G3", (3.5, -3))
      node("Vo", (5, 1.2), label: $V_o$)
      wire("Vo_junc", "Vo")
  })
}

// CIRCUIT 2: PNP Current Mirror
#let pnp_current_mirror() = {
  zap.circuit({
      import zap: *
      set-style(variant: "ieee")
      
      // VCC supply at top
      vcc("Vcc", (-3, 4), label: "15V")
      
      // Q2 (Reference transistor) - PNP
      bjt("Q2", (-3, 1.5), polarisation: "pnp", label: "Q2\n2N3906")
      
      // Q3 (Output transistor) - PNP
      bjt("Q3", (2, 1.5), polarisation: "pnp", label: "Q3\n2N3906")
      
      // Connect collectors to VCC
      node("Vcc_c", (-3, 3.5))
      wire("Vcc_c", "Q2.c")
      wire("Vcc_c", (-3, 4))
      
      node("Vcc_c2", (2, 3.5))
      wire("Vcc_c2", "Q3.c")
      wire("Vcc_c2", (-3, 4))
      
      // Base connection - Q2 and Q3 bases tied together
      node("base_node", (-0.5, 2.8))
      wire("Q2.b", "base_node")
      wire("Q3.b", "base_node")
      
      // RREF and RX for reference current
      node("ref_top", (-3, 3.5))
      resistor("RREF", "ref_top", (-3, 2.5), label: "RREF")
      node("ref_mid", (-3, 2.5))
      wire("Q2.b", "ref_mid")
      
      // RX load (temporary)
      node("Io_node", (2, 0.8))
      wire("Q3.e", "Io_node")
      resistor("RX", "Io_node", (2, -1.5), label: "RX 3.9kΩ")
      earth("G_mirror", (2, -1.5))
      
      // Reference emitter to ground
      node("ref_e", (-3, 0.8))
      wire("Q2.e", "ref_e")
      earth("G_ref", (-3, -1.5))
      wire("ref_e", (-3, -1.5))
      
      // Output current label
      node("Io_out", (3.5, 0.8), label: $I_o$)
      wire("Io_node", "Io_out")
  })
}

// CIRCUIT 3: CE Amplifier with Active Load (Current Source)
#let ce_active_load() = {
  zap.circuit({
      import zap: *
      set-style(variant: "ieee")
      
      // Central NPN Transistor Q1
      bjt("Q1", (-2, 0), polarisation: "npn", label: "Q1\n2N3904")
      
      // Input Section
      node("bjt", (-5, 0))
      wire("bjt", "Q1.b")
      node("Vi", (-10, 0), label: $V_i$)
      capacitor("C1", "Vi", "bjt", label: "C1\n1µF")
      
      // Voltage Divider Biasing
      vcc("Vcc1", (-5, 3), label: "15V")
      resistor("R1", "Vcc1", "bjt", label: "R1 47kΩ")
      resistor("R2", "bjt", (-5, -3), label: "R2 33kΩ")
      earth("G1", (-5, -3))
      
      // Collector Branch - Connected to Current Source Q3
      node("Cj", (-2, 1.2))
      wire("Cj", "Q1.c")
      
      // Active Load: PNP Current Source Q3
      bjt("Q3", (-2, 2.5), polarisation: "pnp", label: "Q3\n2N3906")
      wire("Q3.c", (-2, 3.2))
      vcc("Vcc2", (-2, 3.5), label: "15V")
      wire((-2, 3.2), (-2, 3.5))
      
      // Connect Q1 collector to Q3 emitter
      wire("Cj", "Q3.e")
      
      // Q3 base connected to reference current mirror circuit
      node("base_ref", (1, 2.5))
      wire("Q3.b", "base_ref")
      wire("base_ref", (2, 2.5))
      
      // Reference transistor Q2 (off to the side)
      bjt("Q2", (2, 2.5), polarisation: "pnp", label: "Q2\n2N3906")
      vcc("Vcc3", (2, 3.5), label: "15V")
      wire("Q2.c", (2, 3.5))
      
      // Connect Q2 and Q3 bases together
      wire("Q2.b", "base_ref")
      
      // RREF for reference current
      node("ref_top", (2, 3.2))
      resistor("RREF", "ref_top", (2, 2.0), label: "RREF")
      wire("Q2.b", (2, 2.0))
      
      // Q2 emitter to ground
      node("Q2e", (2, 1.0))
      wire("Q2.e", "Q2e")
      earth("G_ref", (2, 0))
      
      // Emitter Branch for Q1
      node("Ej", (-2, -1.2))
      wire("Q1.e", "Ej")
      resistor("Re", "Ej", (-2, -3), label: "RE 1.8kΩ")
      earth("G2", (-2, -3))
      
      // Emitter Bypass Capacitor
      wire("Ej", (1, -1.2))
      capacitor("Ce", (1, -1.2), (1, -3), label: "CE\n10µF")
      earth("G4", (1, -3))
      
      // Output Section
      wire((-2, 1.2), (0, 1.2))
      capacitor("C2", (0, 1.2), (3.5, 1.2), label: "C2\n1µF")
      node("Vo_junc", (3.5, 1.2))
      resistor("RL", "Vo_junc", (3.5, -3), label: "RL 2.2kΩ")
      earth("G3", (3.5, -3))
      node("Vo", (5, 1.2), label: $V_o$)
      wire("Vo_junc", "Vo")
  })
}

// Example usage - uncomment to render
// #ce_resistor_biasing()
// #pagebreak()
// #pnp_current_mirror()
// #pagebreak()
// #ce_active_load()