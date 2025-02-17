# Experimental!
~ "server" ~ MakeRoutes! Run‼

# MakeRoutes!(p)
AocPage ~ "p/aoc-page.ua"
Index ~ "p/index.ua"
Example ~ "p/example.ua"
Albums ~ "p/albums.ua"

FileRoutes ← ⍣(
  ⍩AocPage~GET °⊓"GET" "/p/aoc-page.ua"
| ⍩Index~GET °⊓"GET" "/p/index.ua"
| ⍩Albums~GET °⊓"GET" "/p/albums.ua"
| ⍩Albums~POST °⊓"POST" "/p/albums.ua"
| ⍩Example~GET °⊓"GET" "/p/example.ua"
| ⍩⍤"Invalid route."0
)

Routes ← ⍣(
  ⍩Index~GET ⋅°"/"
| ⍩FileRoutes
)

Handle ← ⨬(
  "500 Internal Server Error" "text/plain" utf₈
| "404 Not Found" "text/plain" utf₈"Not Found"
)⊸≍"Invalid route."

Run‼(Routes|Handle)
