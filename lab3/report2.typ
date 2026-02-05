#import "../lab_report_template_main.typ": *
#show: lab_report.with(
  experiment_number: 3,     // Optional: Your experiment number
  title: "Active Loading",
  authors: ("Daniel Blue", "Ethan Searls", "Levi Interian-Uc"),
  course: "Laboratory Report for ENGE 312\nApplications of Electronic Devices",
  institution: "George Fox University",
  location: "Newberg, OR",
  date: "Feb 05, 2026",  // or use none for automatic date
  show_copyright: true      // Set false for student reports
)

= Results: Sample Calculations

== 1. Resistor Biased "CE" Amplifier
Given:
- $V_("CC") = 15 "V"$
- $R_1 = 47 "k" Omega$, $R_2 = 33 "k" Omega$
- $R_C = 2.2 "k" Omega$, $R_E = 1.8 "k" Omega$, $R_L = 2.2 "k" Omega$
- Transistor $Q_1$ (2N3904): Assume $beta approx 130$, $V_("BE") approx 0.7 "V"$

*Thevenin Equivalent Base Circuit:*
$ R_B = R_1 || R_2 = (47 "k" dot 33 "k") / (47 "k" + 33 "k") approx 19.39 "k" Omega $
$ V_("BB") = V_("CC") dot (R_2) / (R_1 + R_2) = 15 "V" dot (33) / (80) = 6.19 "V" $

*Q-Point Analysis:*
$ I_("CQ") &= (V_("BB") - V_("BE")) / (R_E + R_B/beta) \
         &= (6.19 "V" - 0.7 "V") / (1.8 "k" Omega + (19.39 "k" Omega)/130) \
         &= (5.49 "V") / (1.8 "k" Omega + 0.15 "k" Omega) \
         &= 2.81 "mA" $

$ V_("CE") &= V_("CC") - I_("CQ")(R_C + R_E) \
         &= 15 "V" - 2.81 "mA"(2.2 "k" Omega + 1.8 "k" Omega) \
         &= 15 "V" - 11.24 "V" \
         &= 3.76 "V" $

*AC Gain ($A_V$):*
$ V_T approx 26 "mV" $
$ g_m = I_("CQ") / V_T = (2.81 "mA") / (26 "mV") approx 0.108 "S" $
$ R_("ac") = R_C || R_L = (2.2 "k" dot 2.2 "k") / (2.2 "k" + 2.2 "k") = 1.1 "k" Omega $
$ A_V &= -g_m (R_("ac")) \
      &= -(0.108 "S")(1100 Omega) \
      &= -118.8 $

*Output Swing:*
$ V_(o, "max") &= V_("CE") - V_("CE", "sat") approx 3.76 "V" - 0.2 "V" = 3.56 "V" $
$ V_(o, "min") &= I_("CQ")(R_C || R_L) = (2.81 "mA")(1.1 "k" Omega) = 3.09 "V" $
$ V_(o, "p-p") &= 2 dot min(V_(o, "max"), V_(o, "min")) \
              &= 2 dot 3.09 "V" = 6.18 "V" $

== 2. Current Mirror (Active Load Setup)
Given:
- Target $I_o approx I_("CQ") approx 2.81 "mA"$ (matching the "CE" stage)
- $V_("CC") = 15 "V"$
- $Q_2, Q_3$ (2N3906): Assume $beta approx 150$, $V_("BE") approx 0.7 "V"$

*Reference Current Setting:*
To match $I_o$ to $I_("CQ")$, we calculate the required $R_("ref")$:
$ R_("ref") &= (V_("CC") - V_("BE")) / I_("ref") \
           &approx (15 "V" - 0.7 "V") / (2.81 "mA") \
           &= 14.3 "V" / 2.81 "mA" \
           &= 5.09 "k" Omega $
_(Note: In lab, use a potentiometer or series resistors to approximate $5.1 "k" Omega$)_

*Output Current:*
$ I_o = I_("ref") / (1 + 2/beta) = (2.81 "mA") / (1 + 2/150) approx 2.77 "mA" $

== 3. "CE" Amplifier with Active Load (Current Source Biasing)
Given:
- Load $R_L = 2.2 "k" Omega$
- Bias $I_C approx 2.8 "mA"$
- Assume Early Voltage resistance $r_o = 30 "k" Omega$ for all transistors[cite: 49].

*Voltage Gain with Active Load:*
The "ac"tive load repl"ac"es $R_C$ with the output resistance of the current mirror ($r_o$ of PNP).
$ R_("eff") &= r_(o, "NPN") || r_(o, "PNP") || R_L \
          &= 30 "k" Omega || 30 "k" Omega || 2.2 "k" Omega \
          &= 15 "k" Omega || 2.2 "k" Omega \
          &= (15 "k" dot 2.2 "k") / (15 "k" + 2.2 "k") approx 1.92 "k" Omega $

$ A_V &= -g_m (R_("eff")) \
      &= -(0.108 "S")(1920 Omega) \
      &= -207.4 $

_(Note: The gain increases significantly compared to the resistor biased version ($119$ vs $207$) due to the higher "eff"ective AC impedance at the collector, even though $R_L$ dominates in this loaded case.)_


= Discussion

= Appendix
