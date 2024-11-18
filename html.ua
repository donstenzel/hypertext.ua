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
  ⟜⟜⟜⟜⟜∘ °□₁
  $$ ┌─╴_
  $$   ~{Attributes Content Type ← "_"}
  $$   # Creates a new element of type _.
  $$   # _!(Attrs){Content}
  $$ └─╴
  $$ _! ←^ ⍚(
  $$   ⌝⊝ ", "
  $$   ⍚°$"\_ → \"\_\""
  $$   $"_ map \_ \_"
  $$ )
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

  # Escapes certain characters for html.
  Sanitize ← (
    Replace @& "&amp;"
    Replace @< "&lt;"
    Replace @> "&gt;")

  # Creates a tag that is placed on newlines and also places
  # its content on newlines.
  Expanded! ←^ ⍚(
    ⟜∘ °$"\"_\""
    $$ ⊓FmtAttrs(Indent /◇⊂ ⍚Render)
    $$ $"\n<_\_>\n\_\n</_>\n"
  )

  # Creates a tag that is placed on newlines but inlines
  # its content.
  Simple! ←^ ⍚(
    ⟜∘ °$"\"_\""
    $$ ⊓FmtAttrs(⊝@\n ⍚Render)
    $$ $"\n<_\_>\_</_>\n"
  )

  # Creates a tag that is inlined.
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
