# Experimental!
~ "lib" ~ Replace

Uiua ← ⋅⊙◌ &runc {"uiua" "run" ∘}

FilesRecursive ← |1 (
  ⊕□⊸≡&fif &fld
  ⍜⊢◇⍚FilesRecursive
  /◇⊂)

DirsRecursive ← |1 (
  ⊕□⊸≡&fif &fld
  ⊂⊸◇(/⊂⍚DirsRecursive) ⊢
  /◇⊂
)

IN  ← "blueprint"
OUT ← "root"

# make sure directories exist
MakeSkel ← (
  DirsRecursive IN
  ⍚(&fmd ⊂OUT⌝⊂IN)
)

Generate ← (
  FilesRecursive IN
  ⍚⍣(
    ⊸Uiua                 # interpret file
    Replace "\\n" "\n"    # unescape newlines
    °$"\"_\"\n"           # revert stdout formatting
    ⊂OUT⌝⊂IN:             # change path root folder
    Replace ".ua" ".html" # change file extension
    &fwa                  # write
  ) ◌                     # ignore empty output
)

# MakeSkel
# Generate
