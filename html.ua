~ "utils" ~ IndentBy Replace ⊝

FmtAttrs   ← ⍥$" _"±◇⊸⧻ ⊝@\s ⍚₁/$"_=\"_\""

# Escapes certain characters for html.
Escape ← (
  Replace @& "&amp;"
  Replace @< "&lt;"
  Replace @> "&gt;"
)

S ← ⍥($"\n_\n"⍜⊜□⍚$"  _"⊸≠@\n)⤚∊⊙@\n
I ← ⍜⊜□⍚$"  _"⊸≠@\n
M ← ¬↥⊓(≍[]|≍0)⊃△⧻
B ← ⍥($"\n_\n"I)⊃M/◇$"_\n_"
T ← ⨬(∘|S|B|∘)⊸type

# use fill value for attributes.
# inlining behavior based on content:
# - single line string → same line tag
# - multi line string → expanded tag
# - number / complex (array) → same line tag
# - scalar box → forces inline
# - empty box array → same line empty tag
# - box array → each element is indented and joined with newlines
# since tags eagerly produce strings, nested tags
# can be boxed to force expansion if there is only
# a single sub element: `Div □₁ A "Link"`
# Alternatively, if you wish to have multiple
# tags on the same line, like in a `<pre><code>` block,
# you can simply box the inner element.
# html ? name content
Tag ← $"<__>_</_>" ⤚⊙⊓(FmtAttrs⍣°◌[]|T)

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
    $$ # See `Tag` for explanation of inlining.
    $$ # _ ? content
    $$ _
  ).⤚⋅°$$ "_"

  ⍜°$"_ ← _"⊃Doc⋅$"⬚⍣°◌[]Tag _"
)

Normal!(
  A ← "a"
| B ← "b"
| Body ← "body"
| Button ← "button"
| Code ← "code"
| Div ← "div"
| Form ← "form"
| H₁ ← "h1"
| H₂ ← "h2"
| H₃ ← "h3"
| H₄ ← "h4"
| H₅ ← "h5"
| H₆ ← "h6"
| Head ← "head"
| Header ← "header"
| Input ← "input"
| Label ← "label"
| LI ← "li"
| Main ← "main"
| Nav ← "nav"
| Option ← "option"
| P ← "p"
| Pre ← "pre"
| Sample ← "sample"
| Script ← "script"
| Select ← "select"
| Span ← "span"
| Style ← "style"
| Title ← "title"
| UL ← "ul"
)
