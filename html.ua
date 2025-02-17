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
# - empty → tag without content
# - single box → tag with inlined content
# - anything else → expanded tag
# html ? name content
Tag ← ⨬(
  $"<__>" ⊙(FmtAttrs ⍣°◌[])
| ⤚⊙⊓(FmtAttrs ⍣°◌[]|FmtContent)
  $"<__>_</_>"
| ⤚⊙⊓(FmtAttrs ⍣°◌[]|IndentBy "  " FmtContent)
  $"<__>\n_\n</_>"
)↧₂◡⋅⧻

T! ←^ ⍚$"⬚⍣°◌[]Tag _"

A      ← T!"a"
Body   ← T!"body"
Button ← T!"button"
Code   ← T!"code"
Div    ← T!"div"
Form   ← T!"form"
H₁     ← T!"h1"
H₂     ← T!"h2"
H₃     ← T!"h3"
H₄     ← T!"h4"
Head   ← T!"head"
Html   ← T!"html"
Input  ← T!"input"
LI     ← T!"li"
Link   ← T!"link"
Meta   ← T!"meta"
Option ← T!"option"
P      ← T!"p"
Sample ← T!"sample"
Select ← T!"select"
Style  ← T!"style"
Title  ← T!"title"
UL     ← T!"ul"
