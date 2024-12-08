# Experimental!
~ "fns" ~ LoadPage Replace Uiua

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
    ⊸LoadPage             # interpret file
    ⊂OUT⌝⊂IN:             # change path root folder
    Replace ".ua" ".html" # change file extension
    &fwa                  # write
  ) ◌                     # ignore empty output
)
