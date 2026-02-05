#import "../lab_report_template_main.typ": *

#show: lab_report.with(
  experiment_number: 3,     // Optional: Your experiment number
  title: "Active Loading",
  authors: ("Daniel Blue", "Ethan Searls", "Levi Interian-Uc"),
  course: "Laboratory Report for ENGE 312\nApplications of Electronic Devices",
  institution: "George Fox University",
  location: "Newberg, OR",
  date: "Feb 05, 2026",  // or use none for automatic date
  show_copyright: false      // Set false for student reports
)
// 1. Move table captions to the top
#show figure.where(kind: table): set figure.caption(position: top)

// 2. Align the caption text to the left
#show figure.caption: set align(left)

// 3. Force the figure container to take full page width
// (This ensures the caption sits at the page margin, not the table edge)
#show figure: set block(width: 100%)
#figure(
  image("/assets/image.png"),
  caption: [CE amplifier without active loading.]
) <basic_amp_diagram>
#figure(
  image("/assets/image-1.png"),
  caption: [Current Mirror]
)
#figure(
  image("/assets/image-2.png"),
  caption: [CE Amplifier with active loading from the current mirror]
)<amp-current-mirror>

= Results
// Table 1: DC Operating Points (Q-Points)
#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
    inset: 4pt,
    align: left,
    //fill: (col, row) => if row == 0 { luma(230) } else { none },
    
    // Header
    table.header(
      [], 
      table.cell(colspan: 3)[*(Resistor)*], 
      table.cell(colspan: 3)[*(Current Mirror)*], 
      table.cell(colspan: 3)[*(Active Load)*]
    ),
    
    // Sub-header
    [*Param*], [*Meas*], [*Theo*], [*% Diff*], 
    [*Meas*], [*Theo*], [*% Diff*], 
    [*Meas*], [*Theo*], [*% Diff*],

    // Row 1: Current
    [$I_C$ / $I_O$], [2.80 mA], [2.81 mA], [0.13%],
    [2.80 mA], [2.81 mA], [0.13%],
    [2.88 mA], [2.81 mA], [0.62%],

    // Row 2: Voltage
    [$V_"CE"$ / $V_O$], [3.78 V], [3.76 V], [0.13%],
    [14.30 V], [10.92 V], [6.70%],
    [4.63 V], [3.76 V], [5.18%],
  ),
  caption: [DC Operating Point Comparison across all circuits.]
) <dc_table>


// Table 2: Amplifier Gain Comparison (Loaded vs Active)
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 8pt,
    align: center,
    //fill: (col, row) => if row == 0 { luma(230) } else { none },

    // Header
    table.header(
      [*Configuration*], 
      [*Measured $A_v$*], 
      [*Theoretical $A_v$*], 
      [*% Difference*]
    ),

    // Data
    [Resistor Bias], [-107 V/V], [-122 V/V], [-3.28%],
    [Active Load], [-244 V/V], [-204 V/V], [-4.46%],
  ),
  caption: [Voltage Gain Comparison]
) <gain_table>


// Table 3: Output Swing Analysis (Maximum & Minimum)
#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 8pt,
    align: center,
    //fill: (col, row) => if row == 0 { luma(230) } else { none },

    // Header
    table.header(
      [*Parameter*], 
      [*Measured (V)*], 
      [*Theoretical (V)*], 
      [*% Difference*]
    ),

    // Data
    [$v_(o,max)$], [2.56 V], [3.56 V], [8.17%],
    [$v_(o,min)$], [3.72 V], [3.09 V], [4.62%],
    [$v_(o,p-p)$], [6.28 V], [6.18 V], [0.39%],
  ),
  caption: [Output Voltage Swing Analysis (Clipping Limits).]
) <swing_table>
#figure(
  image("Figure_1.png"),
  caption: [Graph of AC Load Lines of the two amplifiers used in the experiment. The dotted line is the current mirrored active load amplifier with no load resistor.]
) <ac_load_line_graph>


= Discussion
The percent differences between lab measurements and hand calculations seemed to be fairly small; for most, the difference is 5%, with a couple of outliers like $V_("o,max")$ and $V_O$. This is probably due to some human error. Of course, for some of the calculations, lab measurements had to be used, since for the current meter, the ideal is that it would match the measured current in the lab when looking at the analysis. The current meter seemed to shift the Q point of the amplifier a little bit when added, at least experimentally, since it shouldn't change the Q point, or increase the gain. The change to a current mirror at the emitter did bring a very similar calculated gain increase. The load resistor decreases the amount of gain possible..

#pagebreak()
= Sample Calculations
$ I_("CQ") &= (V_("BB") - V_("BE")) / ( (R_E/alpha) + (R_B/beta)) \ 
           &= (8.13V - 0.7V) / (((1.8k Omega) / alpha) + ((19k Omega) / 130) \
   I_("CQ")&= 2.8 "mA" $ \

$ V_("CE")&= V_("CC") - (R_("CC") + R_E / alpha)I_("CQ") \
          &=  15V - (2.2k Omega + (1.8k omega) / 0.99)(2.8 "mA") \
  V_("CE")&= 3.76V $ \

$ A_V &= -(beta V_T) / I_("CQ")(R_o || R_c || R_L) \
      &= -(130 * 25 "mV") / (2.8 "mA")(30k Omega || 30k Omega || 2.2k Omega) \
      A_V &= -122 V/V
$ \


$ V_("o,max") &= V_("CE") - v_("CE,sat") \ 
  &= 3.76V - 0.2 V \
  &= 3.56V $ \

$ V_("o,min") &= (R_C || R_L)I_("CQ") \
    &= (2.2k Omega || 2.2k Omega) * 2.8 "mA" \
    &= 3.09V $ \


$ I_("ref") &= (V_("CC") - V_("BE")) / (I_("REF")) \
&= (15-0.7V)/(2.8 "mA") \
&= 5.1k Omega  $
$ I_o &= I_("ref")  /  (1 + 2/beta) \
      &= (5.1k Omega) / (1 + 2/150) \
      &= 2.80 "mA"
$ \


$ V_("o") &= I_o * R_X \
&= 2.8 "mA" * 3.9k Omega \
&= 10.92V $ \
