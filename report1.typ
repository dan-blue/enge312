#import "lab_report_template_main.typ": *
#import "circuit.typ": *
#import "table.typ": *

#show: lab_report.with(
  experiment_number: 1,     // Optional: Your experiment number
  title: "Biasing of Common-Emitter Amplifers",
  authors: ("Daniel Blue", "Ethan Searls", "Levi Interian-Uc"),
  course: "Laboratory Report for ENGE 312\nApplications of Electronic Devices",
  institution: "George Fox Unversity",
  location: "Newberg, OR",
  date: "Jan 29, 2026",  // or use none for automatic date
  show_copyright: true      // Set false for student reports
)

= PROJECT DESCRIPTION
The gain and bias stability of a common-emitter amplifier circuit was investigated in this laboratory experience. 
The gain of the amplifier was measured and compared between $beta$ values. Max Voltage Swing ($V_(o,p-p)$) was also measured and compared between $beta$ values. 
\ \

= THEORETICAL BACKGROUND
Consider the circuit shown in #figref(<fig-ce-amp-circuit>). It is a bjt amplifer in the common-emitter configuration. It consists of a NPN Bipolar Junction Transistor (BJT), some resistors, a power source, and some DC filtering capacitors. A BJT has three operating regions. They are the active, saturation, and cutoff regions. In order to amplify an input signal with minimal distortion, the most linear region must be used. Crossing into a nonlinear region adds distortion to the output signal. The linear region for a BJT is the active region.

How does a BJT in a common-emitter configuration amplify?

Why is biasing required, and how is the Q-point established?

How do the node voltages and currents relate to operating region and linearity?




#figure(
  norm_bjt_amp(),
  caption: fig_caption[BJT Amplifier in the Common Base Configuration] 
) <fig-ce-amp-circuit>


$ R_B = R_1 || R_2 $ <eq-RB>
$ V_("BB") = (R_2 / (R_1 + R_2))(V_("CC")) $ <eq-VBB>

$ I_(\C\Q) = (V_(\B\B) - V_(\B\E)) / ((R_E / alpha) + (R_B /beta)) $ <eq-ICQ>
$ V_("CEQ") = V_("CC") - (R_("CC") +  R_E / alpha) I_("CQ") $ <eq-VEQ>

\ \
= METHODS AND MATERIALS

== Equipment

#table_caption[
  *Table 1.* Bench laboratory equipment used in this procedure.
]
#align(center)[
  #table(
    align: center,
    columns: 3,
    [*Manufacturer*], [*Serial Number*], [*Function*],
    [Tektronix ], [CPS250], [Power Supply],
    [Tektronix ],[TDS2024C], [Oscilliscope],
    [Fluke], [45], [Digital Multimeter],
    [VOLTEQ], [SFG-1010], [Functon Generator]
  ) 
]<tab-equipment>

\ \

== Experimental Procedure
The circuit in #figref(<fig-ce-amp-circuit>) was constructed as shown, save for the $R_E$ resistor, which was changed to $2k Omega$ due to insufficent resistor values in the lab. $V_i$ was connected to connected to the function generator. $V_("CC")$ was connected to the benchtop power supply. 
All Q-point node voltages were recorded and verified, as well as verifying that $V_(\B\E) = +0.7V$. The DC blocking of the capacitors was also verified. From the data, $I_(\C\Q)$ and $V_(\C\E)$ were calculated. These were then compared to the prelab results. $beta$ was calculated using the measured and calculated voltages, and then compared to the measuread $beta$ from the multimeters $\h\f\e$ measurement mode.

The function generator was then turned on and set to 50 kHz. Using the oscilliscope, the $v_i$ and $v_o$ were measured, and the amplitude of the waveform from the function generator was adjusted until the $v_o$ waveform appeared to be a pure sine wave (with the exception of some noise).
The max output peak-to-peak voltage was measured by adjusting the input voltage until just before it started clipping. To verify the voltage swing was measured with a waveform that had minimal harmonic distortion or clipping, an FFT was taken of the output signal. The peak-to-peak values of $v_i$ and $v_o$.

Similar steps were then repeated with a different BJT transistor to verify the effects of a change in $beta$, and how effective the bias stability provided by $R_E$ is.

Bandwidth measurements were taken by using the function generator to scan through the frequency spectrum to observe if the amplifiers gain increased substantially. High and low drop off frequencies were recorded, these became $f_("upper")$ and $f_("lower")$ respectivly. These are the points are the $3"dB"$ down points where the output has dropped by a factor of $0.707$. The midband frequency $f_("mid")$ was calculated using the geometric mean.

Laboratory analysis included comparing theoretical and experimental Q values, gain results, as well as differences between the two transistors used based on their differing $beta$ values. Bias stability conditons were also checked.

\ \

= RESULTS
#let results = csv("q_tab.csv")
#let format_cell(cell) = {
  if cell.starts-with("$") and cell.ends-with("$") {
    math.equation(cell.slice(1, -1))
  } else {
    cell
  }
}
#table(
  align: left,
  columns: 4,
  ..results.flatten().map(format_cell),
)

== Sample Calculations
(if needed)

= DISCUSSION
Your discussion...

= CONCLUSIONS
Your conclusions...
