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

# void tags: area base br col embed hr img input link meta source track wbr

# html ? attributes name
Void ← ˜$"<__>" FmtAttrs

V! ←^ ⍚$"Void ⍣°◌[] _"

N! ←^ ⍚$"⬚⍣°◌[]Tag _"

A      ← N!"a"
Body   ← N!"body"
Br     ← (V!"br")
Button ← N!"button"
Code   ← N!"code"
Div    ← N!"div"
Form   ← N!"form"
H₁     ← N!"h1"
H₂     ← N!"h2"
H₃     ← N!"h3"
H₄     ← N!"h4"
Head   ← N!"head"
Html   ← N!"html"
Input  ← N!"input"
Label  ← N!"label"
LI     ← N!"li"
Link   ← (V!"link")
Meta   ← (V!"meta")
Option ← N!"option"
P      ← N!"p"
Sample ← N!"sample"
Script ← N!"script"
Select ← N!"select"
Style  ← N!"style"
Title  ← N!"title"
UL     ← N!"ul"
