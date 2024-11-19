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
  $$ _! ←^ (
  $$   ⍣⍚°$"\_ → \"\_\""({}{})
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

  AttrMap ← map °⊟ ⍉ [{"∘" "id"} {"⊛" "class"}]
  # Formats the attribute map into html conformant syntax.
  FormatAttributes ↚ (
    °map
    ≡⍣get∘ :¤AttrMap
    ⍚$"_=\"_\""
    ⊝ @\s
    ⨬∘(⊂@\s)⊸(>0⧻))
  FmtAttrs ↚ FormatAttributes
  
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
  )
  
  # html ? uiua-html | string
  Render ← |1 (
    ⍣(⍩(Inline!"a") °A
    | ⍩(Inline!"abbr") °Abbr
    | ⍩(Expand!"address") °Address
    | ⍩(Expand!"area") °Area
    | ⍩(Expand!"article") °Article
    | ⍩(Expand!"aside") °Aside
    | ⍩(Simple!"audio") °Audio
    | ⍩(Inline!"b") °B
    | ⍩(Simple!"base") °Base
    | ⍩(Expand!"base") °Blockquote
    | ⍩(Expand!"body") °Body
    | ⍩(Simple!"br") °Break
    | ⍩(Simple!"button") °Button
    | ⍩(Simple!"canvas") °Canvas
    | ⍩(Simple!"caption") °Caption
    | ⍩(Simple!"cite") °Cite
    | ⍩(Expand!"code") °Code
    | ⍩(Simple!"col") °Col
    | ⍩(Expand!"colgroup") °Colgroup
    | ⍩(Expand!"data") °Data
    | ⍩(Simple!"dd") °DD
    | ⍩(Inline!"del") °Del
    | ⍩(Expand!"details") °Details
    | ⍩(Inline!"dfn") °Dfn
    | ⍩(Expand!"dialog") °Dialog
    | ⍩(Expand!"div") °Div
    | ⍩(Expand!"dl") °DL
    | ⍩(Simple!"dt") °DT
    | ⍩(Inline!"em") °Em
    | ⍩(Simple!"embed") °Embed
    | ⍩(Expand!"fieldset") °Fieldset
    | ⍩(Simple!"figcaption") °Figcaption
    | ⍩(Expand!"figure") °Figure
    | ⍩(Expand!"footer") °Footer
    | ⍩(Expand!"form") °Form
    | ⍩(Simple!"h1") °H₁
    | ⍩(Simple!"h2") °H₂
    | ⍩(Simple!"h3") °H₃
    | ⍩(Simple!"h4") °H₄
    | ⍩(Simple!"h5") °H₅
    | ⍩(Simple!"h6") °H₆
    | ⍩(Expand!"head") °Head
    | ⍩(Expand!"header") °Header
    | ⍩(Inline!"hr") °HR
    | ⍩($"<!DOCTYPE html>\n_" Expand!"html") °Html
    | ⍩(Inline!"i") °I
    | ⍩(Expand!"iframe") °IFrame
    | ⍩(Simple!"img") °Img
    | ⍩(Simple!"input") °Input
    | ⍩(Expand!"ins") °Ins
    | ⍩(Simple!"kbd") °Kbd
    | ⍩(Simple!"label") °Label
    | ⍩(Simple!"legend") °Legend
    | ⍩(Simple!"li") °LI
    | ⍩(Simple!"link") °Link
    | ⍩(Expand!"main") °Main
    | ⍩(Expand!"map") °Map
    | ⍩(Inline!"mark") °Mark
    | ⍩(Expand!"menu") °Menu
    | ⍩(Expand!"meta") °Meta
    | ⍩(Simple!"meter") °Meter
    | ⍩(Simple!"nav") °Nav
    | ⍩(Expand!"ol") °OL
    | ⍩(Expand!"optgroup") °Optgroup
    | ⍩(Simple!"option") °Option
    | ⍩(Simple!"output") °Output
    | ⍩(Expand!"p") °P
    | ⍩(Simple!"picture") °Picture
    | ⍩(Expand!"pre") °Pre
    | ⍩(Inline!"q") °Q
    | ⍩(Inline!"s") °S
    | ⍩(Expand!"samp") °Sample
    | ⍩(Expand!"script") °Script
    | ⍩(Expand!"search") °Search
    | ⍩(Expand!"section") °Section
    | ⍩(Expand!"select") °Select
    | ⍩(Expand!"small") °Small
    | ⍩(Expand!"source") °Source
    | ⍩(Simple!"span") °Span
    | ⍩(Expand!"strong") °Strong
    | ⍩(Expand!"style") °Style
    | ⍩(Inline!"sub") °Sub
    | ⍩(Expand!"summary") °Summary
    | ⍩(Inline!"sub") °Sub
    | ⍩(Simple!"svg") °Svg
    | ⍩(Expand!"table") °Table
    | ⍩(Expand!"tbody") °TBody
    | ⍩(Simple!"td") °TD
    | ⍩(Expand!"template") °Template
    | ⍩(Expand!"textarea") °Textarea
    | ⍩(Expand!"tfoot") °TFoot
    | ⍩(Simple!"th") °TH
    | ⍩(Expand!"thead") °THead
    | ⍩(Simple!"time") °Time
    | ⍩(Simple!"title") °Title
    | ⍩(Expand!"tr") °TR
    | ⍩(Expand!"track") °Track
    | ⍩(Inline!"u") °U
    | ⍩(Expand!"ul") °UL
    | ⍩(Simple!"var") °Var
    | ⍩(Simple!"video") °Video
    | ⍩Sanitize °$"_"
    | ⍩⍤.$"Invalid data: _"
    )
  )
└─╴
