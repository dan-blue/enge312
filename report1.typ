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

= THEORETICAL BACKGROUND
Consider the circuit shown in #figref(<fig-circuit>). It is a bjt amplifer in the common-emitter configuration. 
#figure(
  norm_bjt_amp(),
  caption: fig_caption[BJT Amplifier in the Common Base Configuration] 
) <fig-circuit>

= METHODS AND MATERIALS

== Equipment
Your equipment table...

== Experimental Procedure
Your procedure...

= RESULTS

== Sample Calculations
(if needed)

= DISCUSSION
Your discussion...

= CONCLUSIONS
Your conclusions...
