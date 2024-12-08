# Experimental!
~ "../html"
  ~ A! Body! Code! Div! Head! Html!
  ~ H₁! H₂! H₄! Meta! P! Render
  ~ LI! Link! Title! UL!

Html!() {
  Head!() {
    Title!() □"Advent of Code Solutions"
    Link!(
      rel → "icon"
    | type → "image/x-icon"
    | href → "/root/favicon.ico"
    ) {}
    Meta!(charset → "UTF-8") {}
  }
  Body!() {
    Div!(style → "white-space: pre") {
      UL!()
      ⍚(LI!(){
          ⊃(H₄!() □
          | Code!() {&fras})
        })
      ▽⊸≡◇(⍣(⋅1 ⌝𝄈⊂ ".ua")⋅0)
      &fld "/home/sbinder/aoc-2024/"
    }
  }
}

Render
&p
