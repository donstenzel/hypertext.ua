# Experimental!
FmtAttrs ← ⍥$" _"±◇⊸⧻ /◇$"_ _" ⍚₁/$"_=\"_\""

# Escapes certain characters for html.
# Useful for code blocks.
Escape ← (
  R ← ⍜⊜∘⊞⋅∘⊸⦷⊙:
  R @& "&amp;"
  R @< "&lt;"
  R @> "&gt;"
  R @" "&quot;"
  R @' "&apos;"
)

S ← ⍥($"\n_\n"⍜⊜□⍚$"  _"⊸≠@\n)⤚∊⊙@\n
I ← ⍜⊜□⍚$"  _"⊸≠@\n
M ← ¬↥⊓(≍[]|≍0)⊃△⧻
B ← ⍥($"\n_\n"I)⊃M/◇$"_\n_"
T ← ⨬(∘|S|B|∘)⊸type

~Tag {N C α ← []} $"<_ _>_</_>"⊃(N|/$"_ _"⍚₁/$"_=_"α|T C|N)

~Html {C α ← []} ⊂"<!DOCTYPE html>\n" Tag "html" α:⊃α C

# html ? name attributes
Void ← $"<__>" ⊙FmtAttrs

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

Normal! ←^ /$"_\n_" ⍚(
  Doc ↚ (
    $$ # Creates a new `_` element.
    $$ # To set attribute values, use an array of
    $$ # box string pairs as an optional value `α`.
    $$ # See `Tag` for explanation of inlining.
    $$ # _ ? content
    $$ ~_ 
  ).⤚⋅°$$ "_"

  ⊂⊃Doc⋅$"{C α ← []} Tag _ α:⊃α C" °$"_ ← _"
)

Normal!(
  Div ← "div"
| H₁ ← "h1"
)

Html Div α:{"class" "u-flex"} H₁ "Title"
