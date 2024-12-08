# Experimental!

# Joins `segments` with given `seperator`.
# ⌝⊝ splits a string on `seperator`.
# text ? seperator segments
Join ← ⌅(⍣/◇$"___"⋅""|⊜□¬⊸⦷)
⊝    ← Join

# Replaces occurences of `x` with `y` in `S`
# replaced ? x y S
Replace ← ⍜⊜∘⊞⋅∘⊸⦷⊙:

# Indents each line in `text` by `indent`.
# indented ? indent text
IndentBy ← ⍜⊙(⌝⊝ @\n)⍚⊂ ¤

# runs the interpreter on `file` and returns the output
# stdout ? file
Uiua ← ⋅⊙◌ &runc {"uiua" "run" ∘}

# loads an html.ua page into a string
# page-data ? file
LoadPage ← (
  Uiua
  Replace "\\n" "\n"
  °$"\"_\"\n"
)

# Extracts contens of a single curly brace pair
# and returns a string with an underscore in its place.
# {format-str expression} ? string
Extract ← ⍣{: ⊙($"_\__"):°$"_{_}_"}∘

# Extracts all segments within curly braces and replaces
# them with underscores, returning the string and each segment.
# {format-str expr1..n} ? string
ExtractAll ← ⍜°⊂⊙⇌ ⍥⍜⊢Extract∞ {∘}

# Allows intermittent code and string with curly braces.
Format! ←^ ⍚($"($_ _)" ⊙/$"_ _" °⊂ ExtractAll)
