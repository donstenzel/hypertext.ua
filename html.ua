~ "utils" ~ IndentBy Replace ⊝

FmtAttrs   ← ⍥$" _"±⊸⧻ ⊝@\s ⍚/$"_=\"_\""
FmtContent ← ⍥(⊝@\n)=₂⊸type

# Escapes certain characters for html.
Escape ← (
  Replace @& "&amp;"
  Replace @< "&lt;"
  Replace @> "&gt;"
)

# use fill value for attributes.
# behavior based on content:
# - empty or single box → tag with inlined content
# - more elements → expanded tag
# html ? name content
Tag ← ⨬(
  ⤚⊙⊓(FmtAttrs ⍣°◌[]|FmtContent)
  $"<__>_</_>"
| ⤚⊙⊓(FmtAttrs ⍣°◌[]|IndentBy "  " FmtContent)
  $"<__>\n_\n</_>"
)↥₀-₁↧₂◡⋅⧻

# html ? name attributes
Void ← $"<__>" ⊙FmtAttrs

Html ← ⊂"<!DOCTYPE html>\n" ⬚⍣°◌[]Tag "html"

# Defines void elements.
# `Name ← "element"` defines a Uiua function
# `Name` that creates an `element` html tag.
# The function takes attributes as its only input.
# Multiple elements can be defined via a pack.
Void! ←^ /$"_\n_" ⍚(
  Doc ↚ (
    $$ # Creates a new `_` element.
    $$ # Since this is a void element, it has
    $$ # no content.
    $$ # _ ? attrs
    $$ _
  ).⤚⋅°$$ "_"

  ⍜°$"_ ← _"⊃Doc⋅$"Void _"
)

Void!(
  Area ← "area"
| Base ← "base"
| Br ← "br"
| Col ← "col"
| Embed ← "embed"
| Hr ← "hr"
| Img ← "img"
| Input ← "input"
| Link ← "link"
| Meta ← "meta"
| Source ← "source"
| Track ← "track"
| Wbr ← "wbr"
)

# Defines regular elements.
# `Name ← "element"` defines a Uiua function
# `Name` that creates an `element` html tag.
# The function takes content as its only argument,
# and attributes can be supplied via `fill`.
# Multiple elements can be defined via a pack.
Normal! ←^ /$"_\n_" ⍚(
  Doc ↚ (
    $$ # Creates a new `_` element.
    $$ # To set attribute values, use an array of
    $$ # box string pairs as the fill value.
    $$ # _ ? content
    $$ _
  ).⤚⋅°$$ "_"

  ⍜°$"_ ← _"⊃Doc⋅$"⬚⍣°◌[]Tag _"
)

Normal!(
  A ← "a"
| Body ← "body"
| Button ← "button"
| Code ← "code"
| Div ← "div"
| Form ← "form"
| H₁ ← "h1"
| H₂ ← "h2"
| H₃ ← "h3"
| H₄ ← "h4"
| Head ← "head"
| Header ← "header"
| Input ← "input"
| Label ← "label"
| LI ← "li"
| Main ← "main"
| Nav ← "nav"
| Option ← "option"
| P ← "p"
| Sample ← "sample"
| Script ← "script"
| Select ← "select"
| Span ← "span"
| Style ← "style"
| Title ← "title"
| UL ← "ul"
)
