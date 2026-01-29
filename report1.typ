#import "lab_report_template_main.typ": *
#import "circuit.typ": *
#import "table.typ": *

#show: lab_report.with(
  experiment_number: 1,     // Optional: Your experiment number
  title: "Biasing of Common-Emitter Amplifers",
  authors: ("Daniel Blue", "Ethan Searls", "Levi Interian-Uc"),
  course: "Laboratory Report for ENGE 312\nApplications of Electronic Devices",
  institution: "George Fox University",
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

#figure(
  norm_bjt_amp(),
  caption: fig_caption[BJT Amplifier in the Common-Emitter Configuration] 
) <fig-ce-amp-circuit>

Due to the physical construction of the BJT, when there is a small current through the base ($I_B$), a larger current goes through the collector ($I_C$). The relationship is shown in @eq-dc-gain,  where $beta$ is the DC current gain.

$ I_C = beta I_B $ <eq-dc-gain>

Most amplifier designs are voltage amplifiers, but this amplifies current. Voltage can be amplified by placing a load resistor $(R_L)$ at the collector node, going to ground.

To ensure complete operation in the active region, $V_B$ can be biased using a simple voltage divider from a voltage source. @eq-RB and @eq-VBB show how get a Thevenin equivalent from the voltage divider to set our DC bias.

$ R_B = R_1 || R_2 $ <eq-RB>
$ V_("BB") = (R_2 / (R_1 + R_2))(V_("CC")) $ <eq-VBB>

The formulas for the quiescent current and voltage, which account for the effect of the emitter resistor RE on stability, are given by @eq-ICQ and @eq-VEQ.

$ I_(\C\Q) = (V_(\B\B) - V_(\B\E)) / ((R_E / alpha) + (R_B /beta)) $ <eq-ICQ>
$ V_("CEQ") = V_("CC") - (R_("CC") +  R_E / alpha) I_("CQ") $ <eq-VEQ>

$beta$ and $alpha$ are related using @eq-alpha-beta. This means that $alpha < 1$

$ alpha = beta / (beta + 1) $ <eq-alpha-beta>

Due to the fact that the $beta$ of a transistor can vary dramatically between invidiual units (even amongst those within the same model), some manner of bias stability must be ensured, so that a design can be implemented with less restrictive component tolerances. This is at the sacrifice of some amplifier performance. Generally, to be considered stable the design must satisfy two conditons, that $ V_("BB") >> V_("BE")$ and $R_E >> R_B / (beta +1)$. Without ensured bias stability, the Q point of the amplifier could swing drasticly depending on the $beta$ of the transistor used, causing amplification to enter the cutoff or saturation regions, which would lead to clipping and harmonic distortion.

An amplifier also doesn't have the same performance over the entire frequency spectrum, the bandwidth can be calculated using @eq-midband, where $f_("upper")$ and $f_("lower")$ are 3dB down from the max gain.

$ f_("midband") = sqrt(f_("lower") * f_("upper")) $ <eq-midband>
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
The circuit in #figref(<fig-ce-amp-circuit>) was constructed as shown, save for the $R_E$ resistor, which was changed to $2k Omega$ due to insufficent resistor values in the lab. $V_i$ was connected to the function generator. $V_("CC")$ was connected to the benchtop power supply. 
All Q-point node voltages were recorded and verified, as well as verifying that $V_(\B\E) = +0.7V$. The DC blocking of the capacitors was also verified. From the data, $I_(\C\Q)$ and $V_(\C\E)$ were calculated. These were then compared to the prelab results. $beta$ was calculated using the measured and calculated voltages, and then compared to the measuread $beta$ from the multimeters $\h\f\e$ measurement mode.

The function generator was then turned on and set to 50 kHz. Using the oscilliscope, the $v_i$ and $v_o$ were measured, and the amplitude of the waveform from the function generator was adjusted until the $v_o$ waveform appeared to be a pure sine wave (with the exception of some noise).
The max output peak-to-peak voltage was measured by adjusting the input voltage until just before it started clipping. To verify the voltage swing was measured with a waveform that had minimal harmonic distortion or clipping, an FFT was taken of the output signal. The peak-to-peak values of $v_i$ and $v_o$.

Similar steps were then repeated with a different BJT transistor to verify the effects of a change in $beta$, and how effective the bias stability provided by $R_E$ is.

Bandwidth measurements were taken by using the function generator to scan through the frequency spectrum to observe if the amplifiers gain increased substantially. High and low drop off frequencies were recorded, these became $f_("upper")$ and $f_("lower")$ respectivly. These are the points are the $3"dB"$ down points where the output has dropped by a factor of $0.707$. The midband frequency $f_("mid")$ was calculated using the geometric mean.

Laboratory analysis included comparing theoretical and experimental Q values, gain results, as well as differences between the two transistors used based on their differing $beta$ values. Bias stability conditons were also checked.

\ \ 

= RESULTS

#set table(
  inset: 7pt
)

// Helper function: Bolds the "Table #." prefix, keeps label left, centers table
#let centered_table(table_num, caption_text, table_body) = {
  block(width: 100%)[
    #align(left)[#strong[Table #table_num.] #caption_text]
    #v(0.5em)
    #align(center)[#table_body]
  ]
  v(1.5em)
}

// --- TABLE 2 ---
#centered_table("2", "Comparison of theoretical and measured DC biasing results for the first transistor (Beta ≈ 168)",
  table(
    columns: 4,
    table.header([*Parameter*], [*Theoretical*], [*Measured*], [*% Diff*]),
    ..csv("table/first_transistor.csv").flatten().slice(4) 
  )
)

// --- TABLE 3 ---
#centered_table("3", "DC biasing results for the lower-gain second transistor (Beta ≈ 58.7)",
  table(
    columns: 4,
    table.header([*Parameter*], [*Theoretical*], [*Measured*], [*% Diff*]),
    ..csv("table/second_transistor.csv").flatten().slice(4)
  )
)

// --- TABLE 4 ---
#centered_table("4", "Experimental DC results comparing both transistors for bias stability evaluation",
  table(
    columns: 4,
    table.header([*Parameter*], [*First Transistor*], [*Second Transistor*], [*% Diff*]),
    ..csv("table/beta_v_beta.csv").flatten().slice(4)
  )
)

// --- TABLE 5 ---
#centered_table("5", "Comparison of theoretical calculations and experimental midband gain for the first transistor",
  table(
    columns: 4,
    table.header([*Parameter*], [*Theoretical*], [*Measured*], [*% Diff*]),
    ..csv("table/gain_t1_comparison.csv").flatten().slice(4)
  )
)

// --- TABLE 6 ---
#centered_table("6", "Measured midband voltage gain and output characteristics comparison between transistors",
  table(
    columns: 3,
    table.header([*Metric*], [*Transistor 1*], [*Transistor 2*], [*% Diff*]),
    ..csv("table/gain_comparison.csv").flatten().slice(4)
  )
)

// --- TABLE 7 ---
#centered_table("7", "Numerical verification of DC bias stability design constraints (10x Factor)",
  table(
    columns: 4,
    table.header([*Condition*], [*Target Ratio*], [*Actual Ratio*], [*Status*]),
    ..csv("table/stability_check.csv").flatten().slice(4)
  )
)

// --- TABLE 8 ---
#centered_table("8", "Measured frequency characteristics and bandwidth of the amplifier circuit",
  table(
    columns: 2,
    table.header([*Parameter*], [*Measured Frequency*]),
    ..csv("table/bandwidth.csv").flatten().slice(2)
  )
)
== Sample Calculations
#let vcc = 20
#let r1 = 39000
#let r2 = 10000
#let rc = 3900
#let re = 2200
#let beta = 168
#let vbe = 0.7

$V_(B B) = V_(C C) dot (R_2) / (R_1 + R_2) = 20 "V" dot (10 "k" Omega) / (39 "k" Omega + 10 "k" Omega) approx 4.08 "V" $

$R_B = R_1 || R_2 = (R_1 dot R_2) / (R_1 + R_2) = (39 "k" Omega dot 10 "k" Omega) / (39 "k" Omega + 10 "k" Omega) approx 7.96 "k" Omega $

$V_(C Q) = V_(C C) - I_(C Q) dot R_C = 20 "V" - (1.50 "mA" dot 3900 Omega) approx 14.15 "V" $

$V_(E Q) = I_E dot R_E = 1.50 "mA" dot 2200 Omega approx 3.31 "V" $

*Biasing*

$I_(C Q) approx I_E = (V_(B B) - V_(B E)) / (R_E + R_B / (beta + 1)) = (4.08 "V" - 0.7 "V") / (2200 Omega + (7959 Omega) / (168 + 1)) approx 1.50 "mA" $

$V_(C E Q) = V_(C Q) - V_(E Q) = 14.15 "V" - 3.31 "V" = 10.84 "V" $

*Voltage Gain*

#let v_out_pp = 1.44
#let v_in_pp = 0.0792

$A_v = v_o / v_i = (1.44 "V"_(p-p)) / (0.0792 "V"_(p-p)) approx 18.18 $

/* Theoretical Gain Formula */
$g_m = I_(C Q) / V_T = (1.50 "mA") / (25 "mV") = 0.06 "S" $

$r_e = 1 / g_m approx 16.7 Omega $

$A_v approx - (R_C || R_L) / (r_e + R_(E 1)) $

*Bias Stability*

$V_(B B) >> V_(B E) arrow.r 4.08 "V" >> 0.7 "V" quad thin (checkmark) $

$R_E >> R_B / (beta + 1) arrow.r 2200 Omega >> (7959 Omega) / (169) approx 47.1 Omega quad thin (checkmark) $

*Bandwidth and Percent Difference*

/* Midband Frequency */
$f_(m i d) = sqrt(f_(l o w e r) dot f_(u p p e r)) = sqrt(150 "Hz" dot 2.4 "MHz") approx 19.0 "kHz" $

/* Percent Difference Example for ICQ */
$"Diff" \% = |("Theoretical" - "Measured") / "Theoretical"| dot 100 \% $

$"Diff" \% = |(1.50 "mA" - 1.90 "mA") / (1.50 "mA")| dot 100 \% approx 26.7 \% $

= DISCUSSION
With the inital transistor value ($beta = 168$) it looks as though the calculated and measured values are fairly similar as far as node voltages go. With the second transistor ($Beta = 58.7$), there seemed to be a higher percent difference overall between calculated and measured in regards to the Q point calculatins, this is probably in part because of the fact the $R_E$ got changed to $2k Omega$ instead of $2.2k Omega$ due to equipment constraints. Again, when comparing the two resistors the Q points did move a good amount, but thats mostly due to that resistor change, which affected the bias stability. Both transistors had similar amounts of gain, so it seems like the Q point shift didn't affect it too much. The first transistor's frequency gain band was measured, and it seemed fairly wide, covering most of the auditory frequency spectrum (save for the $f_("lower")$ at 150Hz) and well up past 2MHz.

= CONCLUSIONS
The objectives of the experiment were to verify the voltage gain and DC bias stability of a common-emitter amplifer circut. Overall the theoretical design matched the measured outcomes, and while the Q point did shift when changing transistors, similar gain capabilities were consistent from transistor to transistor. The changed resistor value likely contributed to this.
