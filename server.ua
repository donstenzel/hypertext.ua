~ "utils" ~ Eval Uiua

Extension ← ⍜⇌(▽¬\↥⊸⌕@.)

SpecialMimes ← °⊟⍉[
  {"js" "text/javascript"}
  {"wasm" "application/wasm"}
]

ExtMime ← (
  SpecialMimes □Extension
  ⍣(⊓(°□⊢)◌|◇⊂"text/"◌) ˜▽⊙⊸˜⌕:
)

Path ← ◇∘⊡₁ ⊜□⊸≠@\s &ru"\r\n\r\n"

Respond! ← ◌pool(
  &p$"Request by _" &tcpaddr ⟜⊸Path
  &p$"Path is _" ⟜^0
  &p$"Response is _ bytes.\n" ⊃⊓⧻&cl&w
)

E ← &p$"[Error] _\n"

Run! ← (
  &tcpl "0.0.0.0:8000"
  ⍢(⍣Respond!^0⋅E &tcpa)1
)
