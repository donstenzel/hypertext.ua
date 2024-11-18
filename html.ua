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

Tag!A
Tag!Abbr
Tag!Address
Tag!Area
Tag!Article
Tag!Aside
Tag!Audio
Tag!B
Tag!Base
Tag!Blockquote
Tag!Body
Tag!Break
Tag!Button
Tag!Canvas
Tag!Caption
Tag!Cite
Tag!Code
Tag!Col
Tag!Colgroup
Tag!Data
Tag!DD
Tag!Del
Tag!Details
Tag!Dfn
Tag!Dialog
Tag!Div
Tag!DL
Tag!DT
Tag!Em
Tag!Embed
Tag!Fieldset
Tag!Figcaption
Tag!Figure
Tag!Footer
Tag!Form
Tag!H₁
Tag!H₂
Tag!H₃
Tag!H₄
Tag!H₅
Tag!H₆
Tag!Head
Tag!Header
Tag!HR
Tag!Html
Tag!I
Tag!IFrame
Tag!Img
Tag!Input
Tag!Ins
Tag!Kbd
Tag!Label
Tag!Legend
Tag!LI
Tag!Link
Tag!Main
Tag!Map
Tag!Mark
Tag!Menu
Tag!Meta
Tag!Meter
Tag!Nav
Tag!OL
Tag!Optgroup
Tag!Option
Tag!Output
Tag!P
Tag!Picture
Tag!Pre
Tag!Progress
Tag!Q
Tag!S
Tag!Sample
Tag!Script
Tag!Search
Tag!Section
Tag!Select
Tag!Small
Tag!Source
Tag!Span
Tag!Strong
Tag!Style
Tag!Sub
Tag!Summary
Tag!Sup
Tag!Svg
Tag!Table
Tag!TBody
Tag!TD
Tag!Template
Tag!Textarea
Tag!TFoot
Tag!TH
Tag!THead
Tag!Time
Tag!Title
Tag!TR
Tag!Track
Tag!U
Tag!UL
Tag!Var
Tag!Video

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
  Expand! ←^ ⍚(
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
    ⍣(°A
      ⍩(Inline!"a")
    | °Abbr
      ⍩(Inline!"abbr")
    | °Address
      ⍩(Expand!"address")
    | °Area
      ⍩(Expand!"area")
    | °Article
      ⍩(Expand!"article")
    | °Aside
      ⍩(Expand!"aside")
    | °Audio
      ⍩(Simple!"audio")
    | °B
      ⍩(Inline!"b")
    | °Base
      ⍩(Simple!"base")
    | °Blockquote
      ⍩(Expand!"base")
    | °Body
      ⍩(Expand!"body")
    | °Break
      ⍩(Simple!"br")
    | °Button
      ⍩(Simple!"button")
    | °Canvas
      ⍩(Simple!"canvas")
    | °Caption
      ⍩(Simple!"caption")
    | °Cite
      ⍩(Simple!"cite")
    | °Code
      ⍩(Expand!"code")
    | °Col
      ⍩(Simple!"col")
    | °Colgroup
      ⍩(Expand!"colgroup")
    | °Data
      ⍩(Expand!"data")
    | °DD
      ⍩(Simple!"dd")
    | °Del
      ⍩(Inline!"del")
    | °Details
      ⍩(Expand!"details")
    | °Dfn
      ⍩(Inline!"dfn")
    | °Dialog
      ⍩(Expand!"dialog")
    | °Div
      ⍩(Expand!"div")
    | °DL
      ⍩(Expand!"dl")
    | °DT
      ⍩(Simple!"dt")
    | °Em
      ⍩(Inline!"em")
    | °Embed
      ⍩(Simple!"embed")
    | °Fieldset
      ⍩(Expand!"fieldset")
    | °Figcaption
      ⍩(Simple!"figcaption")
    | °Figure
      ⍩(Expand!"figure")
    | °Footer
      ⍩(Expand!"footer")
    | °Form
      ⍩(Expand!"form")
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
    | °Head
      ⍩(Expand!"head")
    | °Header
      ⍩(Expand!"header")
    | °HR
      ⍩(Inline!"hr")
    | °Html
      ⍩($"<!DOCTYPE html>\n_" Expand!"html")
    | °I
      ⍩(Inline!"i")
    | °IFrame
      ⍩(Expand!"iframe")
    | °Img
      ⍩(Simple!"img")
    | °Input
      ⍩(Simple!"input")
    | °Ins
      ⍩(Expand!"ins")
    | °Kbd
      ⍩(Simple!"kbd")
    | °Label
      ⍩(Simple!"label")
    | °Legend
      ⍩(Simple!"legend")
    | °LI
      ⍩(Simple!"li")
    | °Link
      ⍩(Simple!"link")
    | °Main
      ⍩(Expand!"main")
    | °Map
      ⍩(Expand!"map")
    | °Mark
      ⍩(Inline!"mark")
    | °Menu
      ⍩(Expand!"menu")
    | °Meta
      ⍩(Expand!"meta")
    | °Meter
      ⍩(Simple!"meter")
    | °Nav
      ⍩(Simple!"nav")
    | °OL
      ⍩(Expand!"ol")
    | °Optgroup
      ⍩(Expand!"optgroup")
    | °Option
      ⍩(Simple!"option")
    | °Output
      ⍩(Simple!"output")
    | °P
      ⍩(Expand!"p")
    | ⍩Sanitize °$"_"
    | ⍩⍤.$"Invalid data: _"
    )
  )
└─╴
