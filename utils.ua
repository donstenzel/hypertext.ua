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

# like `Uiua` but takes source code instead of a path
# stdout ? code
Eval ← ⋅⊙◌ &runc {"uiua" "eval" ∘}
