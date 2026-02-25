
#set text(font: "Times New Roman", size: 12pt)

#align(right)[
  Daniel Blue\
  Prelab 5\
  ENGE 312\
  #datetime.today().display("[month repr:long] [day], [year]")
]

#set figure(
  supplement: [Fig.],
  numbering: "1",
)

#show figure.caption.where(kind: image): it => [
  #align(left)[*#it.supplement~#it.counter.display(it.numbering).* #it.body]
]

#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption.where(kind: table): it => [
  #align(left)[*Table #it.counter.display("1").* #it.body]
]
#figure(
    image("assets/jfet_amplifier.png"),
    caption: [ 
        Common-Source Amplifier using the 2N3819 N-channel JFET, schematic from Multisim
    ]
)


#figure(
  pad(left: 1.5em)[
    #table(
      columns: (1fr, 1fr),
      inset: 10pt,
      align: horizon,

      [*Q Point*], [*Value*],
      $I_"D"$, [3.89 mA],
      $V_"DS"$, [6.52 V],
      
      [*Node*], [*Voltage (Volts)*],
      $V_"D"$, [9.17], 
      $V_"G"$, [1.36],
      $V_"S"$, [2.65],
    )
  ],
  kind: table,
  caption: [DC operating point values]
)

#figure(
    grid(
    rows: 2,
    gutter: 1em,
    image("assets/ac_sweep_magnitude.png"),
    image("assets/ac_sweep_phase.png"),

    ),
    caption: [ 
       Bode Plot of Common-Source Amplifier, AC sweep from 0.5Hz, to 500Mhz, Magnitude in V/V
    ]
)

#figure(
  pad(left: 1.5em)[
    #table(
      columns: (1fr, 1fr),
      inset: 10pt,
      align: horizon,
      [*Parameter*], [*Value*],
      [Gain: $A_"M"$], [5.08 V/V],
      [3dB Lower Cutoff: $f_"L"$], [8.87 kHz],
      [3dB Upper Cutoff: $f_"H"$], [153 MHz]
    )
  ],
  kind: table,
  caption: [AC sweep summary]
)
