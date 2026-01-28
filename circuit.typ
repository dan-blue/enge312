#import "@preview/zap:0.5.0"
#let norm_bjt_amp() = {
  zap.circuit({
      import zap: *

      set-style(variant: "ieee")
      // 1. Central Transistor
      // Placed at (-5,0). Anchors 'b', 'c', and 'e' are the pins[cite: 1].
      bjt("Q1", (-2, 0), polarisation: "npn", label: "2N3904")

      // 2. Input Section (Horizontal alignment at y=0)
      node("bjt", (-5, 0))               // Base junction node
      wire("bjt", "Q1.b")                  // Straight wire to base
      node("Vi", (-10, 0), label: $V_i$)
      capacitor("C1", "Vi", "bjt", label: $C_1$ + " 10µF")

      // 3. Voltage Divider Biasing (Vertical alignment at x=-divide_align,
      vcc("Vcc1", (-5, 3), label: "20V")
      resistor("R1", "Vcc1", "bjt", label: $R_1$ + " 39k" + $Omega$)
      resistor("R2", "bjt", (-5, -3), label: $R_2$ + " 10k" + $Omega$)
      earth("G1", (-5, -3))

      // 4. Collector Branch (Vertical alignment at x=0)
      node("Cj", (-2, 1.2))                // Collector junction for output
      wire("Cj", "Q1.c")
      resistor("Rc", (-2, 3), "Cj", label: $R_c$ + " 3.9k" + $Omega$)
      wire((-5, 3), (-2, 3))             // Top horizontal VCC rail

      // 5. Emitter Branch (Vertical alignment at x=0)
      node("Ej", (-2, -1.2))               // Emitter junction for bypass
      wire("Q1.e", "Ej")
      resistor("Re", "Ej", (-2, -3), label: $R_E$ + " 2.2k" + $Omega$)
      earth("G2", (-2, -3))

      // 6. Emitter Bypass Capacitor (Parallel to Re)
      wire("Ej", (1, -1.2))             // Step out to the right
      capacitor("Ce", (1, -1.2), (1, -3), label: $C_E$ + " 20µF")
      earth("G4", (1, -3))

      // 7. Output Section (Horizontal alignment at y=1.2)
      wire((-2, 1.2), (0,1.2))
      capacitor("C2", (0, 1.2), (3.5, 1.2), label: $C_2$ + " 100µF")
      node("Vo_junc", (3.5, 1.2))         // Junction for Load Resistor
      resistor("RL", "Vo_junc", (3.5, -3), label: $R_L$ + " 18k" + $Omega$)
      earth("G3", (3.5, -3))
      node("Vo", (5, 1.2), label: $V_o$)
      wire("Vo_junc", "Vo")               // Output terminal wire
  })

}