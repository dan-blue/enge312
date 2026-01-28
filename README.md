# Electrical Engineering Lab Report Template for Typst

This template implements the "General Guidelines for Writing Electrical Engineering Laboratory Reports" by David Beams and Lucas Niiler (2004, Revised 2026).

## Features

This template enforces all major style guidelines from the document:

### Document Structure
- ✓ Title page with 14pt font
- ✓ Experiment number (optional)
- ✓ Header on content pages showing title and authors
- ✓ Sequential page numbering starting after title page (centered)
- ✓ 12pt font for body text (11pt also acceptable)
- ✓ Times New Roman equivalent (New Computer Modern)
- ✓ Serif font throughout
- ✓ Full-width justified text
- ✓ Proper spacing and margins

### Technical Writing Requirements
- ✓ Passive voice (enforced through writing style, not template)
- ✓ Past tense (enforced through writing style, not template)
- ✓ Professional tone without colloquialisms
- ✓ Variables in italics with non-italicized subscripts
- ✓ Proper equation formatting with right-aligned numbering

### Figures and Tables
- ✓ All figures numbered sequentially
- ✓ Figure captions are left-justified (not centered)
- ✓ Captions in smaller font (10pt) than body text
- ✓ Figures must be cited in text
- ✓ Tables numbered sequentially with legends at top
- ✓ Consistent formatting

### References
- ✓ IEEE-style citation format
- ✓ Numbered references in square brackets
- ✓ Hanging indent for reference list

## Files Included

1. **lab_report_template.typ** - The main template file
2. **example_report.typ** - A complete example demonstrating all features
3. **README.md** - This file

## Installation

1. Install Typst: https://github.com/typst/typst
2. Place `lab_report_template.typ` in your project directory
3. Create your report document and import the template

## Basic Usage

```typst
#import "lab_report_template.typ": *

#show: lab_report.with(
  experiment_number: 5,     // Optional: Your experiment number
  title: "Your Experiment Title",
  authors: ("Author One", "Author Two"),
  course: "Laboratory Report for ENGE 250\nElectrical Circuit Analysis",
  institution: "Your University",
  location: "City, State",
  date: "Month Day, Year",  // or use none for automatic date
  show_copyright: false      // Set false for student reports
)

= PROJECT DESCRIPTION
Your content here...

= THEORETICAL BACKGROUND
Your content here...

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

= REFERENCES
(if you have citations)

= APPENDIX
(if needed)
```

## Template Functions

### Main Template Function

```typst
#show: lab_report.with(
  experiment_number: none, // Optional experiment number
  title: "",               // Experiment title
  authors: (),             // List of author names
  course: "",              // Course name/number
  institution: "",         // Institution name
  location: "",            // City, state
  date: none,              // Date (none = automatic)
  show_copyright: false    // false for student reports
)
```

### Helper Functions

#### Figure References
```typst
// Use @label in text for automatic "Fig. N" formatting
#figref(<my-label>)  // Produces "Fig. N"
```

#### Equation References
```typst
// Use @label in text for automatic "(N)" formatting
#eqref(<my-label>)   // Produces "(N)"
```

#### Table References
```typst
#tableref(<my-label>)  // Produces "Table N"
```

#### Variable Formatting
```typst
// Variables in italics
$V_C$  // VC with non-italic subscript

// Or use helper (for complex cases)
#varsub("V", "CO")  // VCO with non-italic subscript
```

#### Scientific Notation
```typst
#sci(1.602, -19)  // Produces 1.602 × 10^-19
```

#### Code Listings
```typst
#code_listing(
  caption: "Description of code",
  language: "python",  // optional
  ```python
  your code here
  ```
)
```

## Document Structure

Follow this standard structure (as per the style guide):

```
I. PROJECT DESCRIPTION
II. THEORETICAL BACKGROUND
III. METHODS AND MATERIALS
    A. Equipment
    B. Experimental Procedure
    C. Simulation (if applicable)
IV. RESULTS
    A. Sample Calculations (if needed)
V. DISCUSSION
VI. CONCLUSIONS
VII. REFERENCES
```

### Section Headings

```typst
= SECTION TITLE           // Level 1 (uppercase, Roman numerals)
== Subsection Title       // Level 2 (title case)
=== Sub-subsection        // Level 3 (if needed)
```

## Figures

### Creating Figures

```typst
#figure(
  // Your figure content (image, diagram, etc.)
  image("path/to/image.png", width: 5in),
  caption: fig_caption[
    Description of figure. Include all relevant details.
  ]
) <fig-label>
```

### Referring to Figures

```typst
// In text, use @label
The circuit is shown in @fig-circuit.
Results are presented in @fig-results.

// Or use helper function
Results are shown in #figref(<fig-results>).
```

### Figure Guidelines

- All figures must be cited in text before they appear
- Captions should be descriptive and complete
- Use 10pt font for captions (automatic in template)
- Center figures on page
- Keep figures and captions together on same page

## Tables

### Creating Tables

```typst
#figure(
  table(
    columns: 3,
    align: (left, center, right),
    [*Header 1*], [*Header 2*], [*Header 3*],
    [Data 1], [Data 2], [Data 3],
    [Data 4], [Data 5], [Data 6],
  ),
  caption: table_caption[
    Description of table data.
  ],
  kind: table
) <table-label>
```

### Table Guidelines

- Table captions (legends) go at the TOP
- Use 10pt font for captions (automatic)
- Bold column headers
- Align columns appropriately (left/center/right)
- All tables must be cited in text

## Equations

### Writing Equations

```typst
// Inline math
The voltage is $V = I R$ where...

// Display equations with numbering
$ V_C (t) = V_(C O) e^(-t/(R C)) + V_S (1 - e^(-t/(R C))) $ <eq-solution>

// Reference equations
As shown in @eq-solution, the voltage...
```

### Equation Guidelines

- All equations automatically numbered
- Right-aligned numbering
- Variables in italics, subscripts not italicized
- Define all variables
- Reference equations by number

## References

### Adding References

```typst
= REFERENCES

#set par(hanging-indent: 2em, first-line-indent: 0pt)

\[1\] Author Name. _Book Title_. Publisher, Year. #label("ref-label1")

\[2\] Author. "Article Title," _Journal Name_, vol. X, pp. Y-Z, Year. #label("ref-label2")

\[3\] Author. "Online Title," (Date). URL. #label("ref-label3")
```

### Citing in Text

```typst
According to the literature #cite(<ref-label1>), the method...
As shown by Smith #cite(<ref-label2>), the results...
```

## Style Guide Compliance Checklist

### Writing Style
- [ ] Passive voice used throughout
- [ ] Past tense for describing work done
- [ ] No first person (I, we) or second person (you)
- [ ] Professional tone, no colloquialisms
- [ ] Technical accuracy maintained

### Formatting
- [ ] Title page includes all required information
- [ ] Pages numbered starting after title page
- [ ] 12pt font for body text
- [ ] Equations numbered sequentially
- [ ] Variables properly italicized
- [ ] Subscripts non-italic (unless variables themselves)

### Figures and Tables
- [ ] All figures numbered sequentially
- [ ] All figures cited in text
- [ ] Figure captions complete and descriptive
- [ ] Captions left-justified, not centered
- [ ] Tables have legends at top
- [ ] Graph axes labeled with units
- [ ] No excessive whitespace (< 1/4 page)

### Technical Content
- [ ] Circuit diagrams properly drawn
- [ ] SI units used consistently
- [ ] Significant figures appropriate
- [ ] Scientific notation formatted correctly
- [ ] References properly formatted

## Common Issues and Solutions

### Issue: Variables with subscripts
**Solution:** Use `$V_C$` for non-italic subscripts, `$V_i$` for italic subscripts (when subscript is itself a variable).

### Issue: Long equations
**Solution:** Break into multiple lines using `&` for alignment:
```typst
$ x &= a + b + c \
    &quad + d + e + f $
```

### Issue: Whitespace at bottom of page
**Solution:** Move text around figures to minimize gaps. Template automatically helps with this.

### Issue: Figure too large for page
**Solution:** Reduce figure size with `width:` or `height:` parameters:
```typst
image("file.png", width: 80%)
```

## SI Units and Formatting

### Proper SI Unit Usage

```typst
// Correct
1.5 MΩ, 10 μF, 5.2 kHz

// Use proper symbols
Ω (ohm), μ (micro), ° (degree)

// Scientific notation
#sci(1.602, -19) C  // 1.602 × 10^-19 C
```

### Significant Figures

Follow the rules in the style guide:
- Match precision to measurement accuracy
- Non-zero digits are significant
- Trailing zeros after decimal are significant
- Leading zeros are not significant

## Advanced Features

### Custom Figure Types

```typst
// Code listing
#code_listing(
  caption: "Matlab code for analysis",
  ```matlab
  % Your code here
  ```
)

// Circuit schematic (using external tool)
#figure(
  image("circuit.svg"),
  caption: fig_caption[Circuit schematic created in...]
)
```

### Multi-line Equations

```typst
$ V_C (t) &= V_(C O) e^(-t/(R C)) \
          &quad + V_S (1 - e^(-t/(R C))) $ <eq-long>
```

### Complex Tables

```typst
#figure(
  table(
    columns: (auto, 1fr, 1fr),  // Custom column widths
    stroke: none,               // Remove all borders
    [*Parameter*], [*Value*], [*Units*],
    table.hline(),              // Add horizontal line
    [Resistance], [1.0], [MΩ],
    [Capacitance], [1.0], [μF],
  ),
  caption: table_caption[Component values],
  kind: table
)
```

## Compiling Your Document

```bash
# Compile once
typst compile your_report.typ

# Watch for changes and auto-compile
typst watch your_report.typ

# Specify output name
typst compile your_report.typ my_report.pdf
```

## Tips for Best Results

1. **Always cite figures and tables** before they appear in text
2. **Keep captions descriptive** - reader should understand figure without reading full text
3. **Use consistent terminology** throughout document
4. **Define variables** when first introduced
5. **Check significant figures** in all numerical results
6. **Proofread equations** - easy to miss typos in math
7. **Test compile frequently** to catch formatting issues early

## Example Workflow

1. Start with template structure
2. Write section headings
3. Add placeholder figures/tables
4. Write text, citing figures
5. Add actual figures and data
6. Write equations with proper formatting
7. Add references
8. Final proofread and compile

## Support and Resources

- Typst Documentation: https://typst.app/docs
- Typst Math Reference: https://typst.app/docs/reference/math/
- Style Guide: See Lab_Report_Style_Guide_v3.pdf
- Example: See example_report.typ

## License

This template is based on the style guide by David Beams and Lucas Niiler.
Template implementation © 2026, provided as-is for educational use.
