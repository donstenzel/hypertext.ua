# Experimental!
~ "generator" ~ Generate MakeSkel

GetExt       ← ↘+₁⊚⊸⌕@.
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
  Response "200 OK" "text/html" &frab "root/index.html" °"root/"
| ExtMime ⟜&frab
  Response "200 OK"
| Response "404 Not Found" "text/plain" utf₈"Not Found" ◌
) ⊂"root"

Respond ← ◌pool(
  &p$"Request by _" ⊸&tcpaddr
  °□⊡₁ ⊜□⊸≠@\s ⊸&ru "\r\n\r\n"
  &p⊸$"Path is root_"
  HandleRequest
  &p$"Response is _ bytes."⊸⧻
  ⊃⋅&cl&w
)

Server ← &tcpl "0.0.0.0:8000"

MakeSkel
Generate

⍢(⍣Respond⋅&p &tcpa Server)1
