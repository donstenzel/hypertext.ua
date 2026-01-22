# Experimental!
Extension ← ⍜⇌(▽¬\↥⊸=@.)

Mimes ← map°⊟⍉[
  {"js" "text/javascript"}
  {"wasm" "application/wasm"}
  {"json" "application/json"}
  {"png" "image/png"}
  {"gif" "image/gif"}
  {"mp4" "video/mp4"}
  {"ttf" "font/ttf"}
  {"woff" "font/woff"}
  {"woff2" "font/woff2"}
]

Mime ← (
  ⍣get$"text/_" ⊙Mimes Extension
)

Headers ← /$"_\r\n_" ⍚₀$"_: _" °map

┌─╴URL
  # url ? url query fragment
  New ← ⌅(
    ⊂₃⊙⊓(⍥$"?_"±⊸⧻|⍥$"#_"±⊸⧻)
  | ⊙∩↘₁ ⊃↙↘⤚⨂⊙@? ⊃↙↘⤚⨂⊙@#
  )

  Safe ↚ ⊂₄⟜⌵+@a⇡26+@0⇡10"._-~"

  # decodes a single byte
  D ↚ °⊥₁₆⇌⨂HexDigits ¯⌅⌵°$"%_"

  # decodes url percent encoded string
  Decode ↚ ⍜⊜□⍚(
    °utf₈ ⧈D¤¤3
  )±⊸⦷"%\W\W" ⍜▽⋅@\s⊸=@+

  # encodes a single character
  E ↚ /⊂≡°D utf₈

  # encodes url query component
  Encode ↚ ◌°⊕°(⍥E¬⊸∊Safe)

  # formats query components from map
  # query ? kvs
  MakeQuery ← /$"_&_" ⍚$"_=_" ∩⍚Encode °map

  # constructs a map from form-data
  # map ? data
  ParseQuery ← map°⊟⍉⊜{∩Decode °$"_=_"}⊸≠@&

  # formats a query component from a map
  # `°Query` parses a query into a map
  Query ← ⌅(MakeQuery|ParseQuery)
└─╴

~Req {Method Path Query Headers Data}

# request ? handle
Receive ← (
  &rs 1e5 # ∞ doesn't work so here's an arbitrary limit instead.
  °$"_ _ HTTP/1.1\r\n_\r\n\r\n_"
  Req ⊙⊙⊙◌ ⊓⊙°URL°Headers
)

# `code` should be an HTTP return code (i.e. "200 OK"),
# `headers` a map and `data` the raw data in bytes.
# [NOTE] you should always specify a Content-Type header.
# response ? code headers data
Response ← ⊂utf₈$"_\r\n_\r\n\r\n"⊓(
  $"HTTP/1.1 _"
| Headers insert"Content-Length"◡⋅⧻
)
