# Experimental!
~ "fns" ~ LoadPage Uiua

GetExt ← ⍜⇌(▽¬\↥⊸⌕@.)

SpecialMimes ← °⊟⍉[
  {"js" "text/javascript"}
  {"wasm" "application/wasm"}
]

ExtMime ← (
  □GetExt
  SpecialMimes
  𝄈▽⊙⊸𝄈⌕:
  ⍣(⊓(°□⊢|◌)|◇⊂"text/"◌)
)

Response ← (
  ⊙⊙⊸⧻
  $$ HTTP/1.1 _
  $$ Content-Type: _
  $$ Content-Length: _
  $$ 
  $$ 
  ⊂ utf₈
)

HandleRequest ← ⍣(
  Response "200 OK" "text/html" utf₈ LoadPage "index.ua" °"/"
| Response "200 OK" "text/plain" utf₈ "Server is stopping." °"/stop"
| Response "200 OK" "text/html" utf₈ LoadPage ⌝⊂@/ ⍜°$"/p/_.ua"
| Response "200 OK" "text/plain" utf₈ Uiua ⌝⊂@/ ⍜°$"/_.ua"
| Response "404 Not Found" "text/plain" utf₈ "Not Found!" ◌
)

Respond ← recv pool(
  &p$"Request by _" ⊸&tcpaddr
  °□⊡₁ ⊜□⊸≠@\s ⊸&ru "\r\n\r\n"
  &p⊸$"Path is _"
  HandleRequest
  send0⊸(¬/↥⌕"Server is stopping."°utf₈)
  &p$"Response is _ bytes."⊸⧻
  ⊃⋅&cl&w
)

Server ← &tcpl "0.0.0.0:8000"

# print error and continue
# 1 ? error
E ← 1 &p$"Failed to respond!\n_"

Run ← ⍢(|⍣Respond⋅E&tcpa Server)

Run
