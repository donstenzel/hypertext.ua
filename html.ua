#!/usr/bin/env -S uiua run
# Experimental!

# Joins `segments` with given `seperator`.
# ⌝⊝ splits a string on `seperator`.
# text ? seperator segments
Join ← ⌅(⍣/◇$"___"⋅""|⊜□¬⊸⦷)
⊝    ← Join

# Like under, but undoes with different context.
# ⌝F ⊙F : F|2.1
Around! ← ⌝^0⊙^0

# Replaces occurences of `x` with `y` in `S`
# replaced ? x y S
Replace ← ⍜⊜∘⊞⋅∘⊸⦷⊙:

# Indents each line in `text` by `indent`.
# indented ? indent text
IndentBy ← ⍜⊙(⌝⊝ @\n)⍚⊂ ¤

# Indents each line in `text` by 2 spaces.
# indented ? text
Indent ← IndentBy "  "

# Extracts contens of a single curly brace pair
# and returns a string with an underscore in its place.
# {format-str expression} ? string
Extract ← ⍣({: ⊙($"_\__"):°$"_{_}_"}|∘)

# Extracts all segments within curly braces and replaces
# them with underscores, returning the string and each segment.
# {format-str expr1..n} ? string
ExtractAll ← ⍜°⊂⊙⇌ ⍥⍜⊢Extract∞ {∘}

# Allows intermittent code and string with curly braces.
Format! ←^ ⍚($"($_ _)" ⊙/$"_ _" °⊂ ExtractAll)

# Creates a module and macro for html tags.
Tag! ←^ (
  ⟜⟜⟜⟜⟜⟜∘ °□₁
  $$ ┌─╴_ ~ _!
  $$   ~{Attributes Content Type ← "_"}
  $$   # Creates a new element of type _.
  $$   # _!(Attrs){Content}
  $$   _! ←^ ⍚(
  $$     ⌝⊝ ", "
  $$     ⍚°$"\_ → \"\_\""
  $$     $"_ map \_ \_"
  $$   )
  $$ └─╴
)

Tag!Html
Tag!Div
Tag!Code
Tag!A
Tag!P
Tag!H₁
Tag!H₂
Tag!H₃
Tag!H₄
Tag!H₅
Tag!H₆

┌─╴HTML
  # Contains various functions to interact
  # with objects from Tag!-generated Html modules

  # Formats the attribute map into html conformant syntax.
  FormatAttributes ↚ ⨬∘(⊂@\s)⊸(>0⧻) ⊝ @\s ⍚$"_=\"_\"" °map
  FmtAttrs         ↚ FormatAttributes

  Sanitize ← (
    Replace @& "&amp;"
    Replace @< "&lt;"
    Replace @> "&gt;")

  # a simple example
  Example ← Html!() {
    H₁!() {"Uiua HTML Generation"}
    H₂!() {"Overview"}
    Div!() {
      P!(style → "white-space: pre") {
        $ This library allows you to write html using uiua code.
        $ You can easily create static pages with this.
      }
      P!(style → "white-space: pre") {
        $ An example could look like:
        Code!(style → "line-height: 1") {
          $ Example ← Html!() {
          $   H₁!() {"Level 1.1"}
          $   Div!() {
          $     H₂!() {"Level 2.1"}
          $     H₂!() {"Level 2.2"}
          $   }
          $   H₁!() {"Level 1.2"}
          $ }
        }

        $ This would then be turned into:
        Code!(style → "line-height: 1") {
          $ <html >
          $   <h1 >
          $     Level 1.1
          $   </h1>
          $   <div >
          $     <h2 >
          $       Level 2.1
          $     </h2>
          $     <h2 >
          $       Level 2.2
          $     </h2>
          $   </div>
          $   <h1 >
          $     Level 1.2
          $   </h1>
          $ </html>
        }
        $ Note that the contents of each tag are entirely up to you.
        $ They can be regular strings or other tags that are implemented.
      }
      P!(style → "white-space: pre") {
        $ In any given tag like
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
      A!(href → "https://www.github.com/donstenzel") {"GitHub"}
      H₄!() {A!(href → "https://www.github.com/donstenzel/html.ua") {"Source"}}
    }
  } # 

  Expanded! ←^ ⍚(
    ⟜∘ °$"\"_\""
    $$ ⊓FmtAttrs(Indent /◇⊂ ⍚Render)
    $$ $"\n<_\_>\n\_\n</_>\n"
  ) # 

  Simple! ←^ ⍚(
    ⟜∘ °$"\"_\""
    $$ ⊓FmtAttrs(⊝@\n ⍚Render)
    $$ $"\n<_\_>\_</_>\n"
  ) # 

  Inline! ←^ ⍚(
    ⟜∘ °$"\"_\""
    $$ ⊓FmtAttrs(⊝@\n ⍚Render)
    $$ $"<_\_>\_</_>"
  ) # 

  # html ? uiua-html | string
  Render ← |1 (
    ⍣(°Html
      ⍩($"<!DOCTYPE html>\n_" Expanded!"html")
    | °P
      ⍩(Expanded!"p")
    | °Code
      ⍩(Expanded!"code")
    | °Div
      ⍩(Expanded!"div")
    | °H₁
      ⍩(Simple!"h1")
    | °H₂
      ⍩(Simple!"h2")
    | °H₃
      ⍩(Simple!"h3")
    | °H₄
      ⍩(Simple!"h4")
    | °H₅
      ⍩(Simple!"h5")
    | °H₆
      ⍩(Simple!"h6")
    | °A
      ⍩(Inline!"a")
    | ⍩Sanitize °$"_"
    | ⍩⍤.$"Invalid data: _"
    )
  )
└─╴

Save ← ⍜&fras⋅(HTML~Render HTML~Example) "/home/sbinder/uiua-html.html"
Save
