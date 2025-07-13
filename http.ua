# Experimental!
Extension ← ⍜⇌(▽¬\↥⊸=@.)

SpecialMimes ← map°⊟⍉[
  {"js" "text/javascript"}
  {"wasm" "application/wasm"}
  {"json" "application/json"}
  {"png" "image/png"}
  {"gif" "image/gif"}
  {"mp4" "video/mp4"}
  {"ttf" "font/ttf"}
]

ExtMime ← (
  ⍣get$"text/_" ⊙SpecialMimes Extension
)

Headers ← map⊜°◇$"_: _"¬⊸⦷"\r\n"

# method path headers data ? socket
Request ← (
  &rs 1e5 # ∞ doesn't work so here's an arbitrary limit instead.
  °$"_ _ HTTP/1.1\r\n_"
  ⊙⊙(Headers °$"_\r\n\r\n_")
)

# utf₈-response ? code type utf₈-content
Response ← (
  ⊙⊙⊸⧻
  $$ HTTP/1.1 _
  $$ Content-Type: _
  $$ Content-Length: _
  $$ Connection: keep-alive
  $$ 
  $$ 
  ⊂ utf₈
)

# decodes a singly byte
D ↚ °⊥₁₆⇌⊗⊙HexDigits ¯⌵°$"%_"

# decodes url percent encoded string
Decode ← ⍜⊜□⍚(
  °utf₈ ⧈D¤¤3
)±⊸⦷"%\W\W" ⍜▽⋅@\s⊸=@+

# constructs a map from form-data
# map ? data
ParseQuery ← (
  map°⊟⍉⊜{∩Decode °$"_=_"}⊸≠@&
)
