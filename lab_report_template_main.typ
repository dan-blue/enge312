// Electrical Engineering Lab Report Template
// Based on the General Guidelines for Writing Electrical Engineering Laboratory Reports
// by David Beams and Lucas Niiler (2004, Revised 2026)

// Template function that applies all formatting rules
#let lab_report(
  title: "",
  experiment_number: "",
  authors: ("Daniel Blue, Ethan Searls, Levi Uc-Interian"),
  course: "",
  institution: "",
  location: "",
  date: none,
  show_copyright: "",
  body
) = {
  // Set document metadata
  set document(title: title, author: authors)
  
  // Set page configuration
  set page(
    paper: "us-letter",
    margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
    numbering: "1",
    number-align: center,
  )
  
  // Skip numbering on title page
  set page(numbering: none)
  
  // Set text formatting - 12pt Times New Roman equivalent
  set text(
    font: "Liberation Serif",  // Closest to Times New Roman in Typst
    size: 12pt,
    lang: "en"
  )
  
  // Set paragraph formatting
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0pt,
  )
  
  // Configure heading styles - Level 1 with Roman numerals
  set heading(numbering: (..nums) => {
    let values = nums.pos()
    if values.len() == 1 {
      numbering("I.", ..nums)
    } else {
      numbering("A.", nums.pos().last())
    }
  })
  
  show heading.where(level: 1): it => {
    set text(size: 12pt, weight: "bold")
    set block(above: 1.5em, below: 2em)
    grid(
      columns: (2em, 1fr),  // Fixed width for Roman numerals
      column-gutter: 1em,
      align(left, counter(heading).display("I.")),
      upper(it.body)
    )
  }
  show heading.where(level: 2): it => {
    set text(size: 11pt, weight: "bold")
    set block(above: 1.2em, below: 0.8em)
    it
  }
  
  // Configure equations - right-aligned numbering
  set math.equation(numbering: "(1)")
  
  // Configure figures
  set figure(
    gap: 1em,
  )
  
  show figure.caption: it => {
    set text(size: 10pt)
    set align(left)
    block(width: 100%, it)
  }
  
  // Configure tables
  show figure.where(kind: table): set figure(placement: auto)
  
  // --- TITLE PAGE ---
  // Experiment number (if provided)
  v(12em)

  // Experiment title
  align(center)[
    #text(size: 14pt, weight: "bold")[
      Experiment #experiment_number \
      #title \
     
      #course \
      #institution \
      #location \
      #date \
      #v(12em)
      #authors.join(", ")
    ]
  ]
  
  v(1.5em)
   pagebreak()
  
  // Enable page numbering after title page
  set page(
    numbering: "1", 
    number-align: center,
    // Add header with title and authors on subsequent pages
    header: context {
      if counter(page).get().first() > 0 {
        set text(size: 10pt)
        align(center)[
          #title \
          #authors.join(", ")
        ]
        //line(length: 100%, stroke: 0.5pt)
      }
    }
  )
  counter(page).update(1)
  
  // --- MAIN CONTENT ---
  body
}

// Helper function for creating properly formatted figure captions
#let fig_caption(it) = {
  set text(size: 10pt)
  set par(justify: true)
  it
}

// Helper function for creating properly formatted table captions
#let table_caption(it) = {
  set text(size: 10pt, weight: "bold")
  it
}

// Helper function for variables (italicized)
#let var(it) = $italic(#it)$

// Helper function for subscripted variables (non-italicized subscripts)
#let varsub(base, sub) = $italic(#base)_#sub$

// Helper function for references to figures
#let figref(label) = {
  [Fig. #ref(label)]
}

// Helper function for references to equations
#let eqref(label) = {
  [(#ref(label))]
}

// Helper function for references to tables
#let tableref(label) = {
  [Table #ref(label)]
}

// Function for code listings
#let code_listing(
  caption: none,
  code,
  language: none
) = figure(
  kind: "code",
  supplement: [Fig.],
  caption: caption,
  block(
    width: 100%,
    fill: luma(245),
    inset: 10pt,
    radius: 4pt,
    {
      set text(font: "New Computer Modern Mono", size: 10pt)
      code
    }
  )
)

// Scientific notation helper
#let sci(mantissa, exponent) = {
  $#mantissa times 10^#exponent$
}

// Function for creating properly formatted references section
#let references(refs) = {
  heading(numbering: none)[REFERENCES]
  set par(hanging-indent: 2em, first-line-indent: 0pt)
  for (i, ref) in refs.enumerate() {
    block[
      #text[\[#(i + 1)\] ]#ref
    ]
  }
}
