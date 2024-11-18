#!/usr/bin/env -S uiua run
# Experimental!
~ "html.ua" ~ A! Code! Div! HTML Html! H₁! H₂! H₃! H₄! P!

Html!() {
  H₁!() {"Uiua HTML Generation"}
  Div!() {
    H₃!() {"Overview"}
    P!(style → "white-space: pre") {
      $ This library allows you to write html using uiua code.
      $ You can easily create static pages with this.
    }
    P!(style → "white-space: pre; line-height: 1") {
      $ An example could look like:
      Code!() {
        $ Html!() {
        $   H₁!() {"Level 1.1"}
        $   Div!(style → "line-height: 1") {
        $     H₂!() {"Level 2.1"}
        $     H₂!() {"Level 2.2"}
        $   }
        $   H₁!() {"Level 1.2"}
        $ }
      }
      $ This would then be turned into:
      Code!() {
        $ <!DOCTYPE html>
        $ 
        $ <html>
        $   <h1>Level 1.1</h1>
        $   <div style="line-height: 1">
        $     <h2>Level 2.1</h2>
        $     <h2>Level 2.2</h2>
        $   </div>
        $   <h1>Level 1.2</h1>
        $ </html>
      }
      $ Note that the contents of each tag are entirely up to you.
      $ They can be regular strings or other tags that are implemented.
    }
    P!(style → "white-space: pre") {
      $ In any given tag like:
      Code!() {"Html!(...) {...}"}
      $ the parentheses can be used to set attributes,
      $ while the curly braces are used for the content.
      $ 
      $ Attributes are formatted like
      Code!() {"Name₁ → \"Value₁\", Name₂ → \"Value₂\"..."}
      $ where Name and Value can be changed as necessary.
      $ No trailing whitespace or commas are allowed.
      $ Note that whitespace is important.
    }
  }
  Div!() {
    H₃!() {"Check this stuff out!"}
    H₄!() {A!(href → "https://www.github.com/donstenzel") {"GitHub"}}
    H₄!() {A!(href → "https://www.github.com/donstenzel/html.ua") {"Source"}}
  }
}

⍜&fras⋅(HTML~Render) "example.html"
