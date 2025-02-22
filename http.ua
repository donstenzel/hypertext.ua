# Experimental!
Extension ← ⍜⇌(▽¬\↥⊸=@.)

SpecialMimes ← °⊟⍉[
  {"js" "text/javascript"}
  {"wasm" "application/wasm"}
]

ExtMime ← (
  SpecialMimes □Extension
  ⍣(⊓(◇∘⊢)◌|◇⊂"text/"◌) ˜▽⊙⊸˜⌕:
)

# method path data ? socket
Request ← (
  &rs 1e4 # ∞ doesn't work so here's an arbitrary limit instead.
  °$"_ _ HTTP/1.1\r\n_"
  ⊙⊙(◇∘⊣⊜□¬⊸⦷"\r\n\r\n")
)

# utf₈-response ? code type utf₈-content
Response ← (
  ⊙⊙⊸⧻
  $$ HTTP/1.1 _
  $$ Content-Type: _
  $$ Content-Length: _
  $$ 
  $$ 
  ⊂ utf₈
)

# decodes url-querystring
Decode ← ⍜⊜□⍚(
  °utf₈⧈(°base₁₆⇌⊗⊙HexDigits ¯⌵↘₁)¤¤3
)±⊸⦷"%\W\W" ⍜▽⋅@\s⊸=@+

# constructs a map from form-data
# map ? data
ParseQuery ← (
  map°⊟⍉⊜{∩Decode °$"_=_"}⊸≠@&
)
