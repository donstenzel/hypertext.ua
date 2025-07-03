# Experimental!
~ "server" ~ MakeRoutes! Run‼

# Call this macro to generate routes based on files
MakeRoutes!"p"
# This is the output:
# AocPage ~ "p/aoc-page.ua"
# Index ~ "p/index.ua"
# Albums ~ "p/albums.ua"
# Example ~ "p/example.ua"
# 
# FileRoutes ← ⍣(
#   ⍩AocPage~GET °("GET" "/p/aoc-page.ua")
# | ⍩Index~GET °("GET" "/p/index.ua")
# | ⍩Albums~GET °("GET" "/p/albums.ua")
# | ⍩Albums~POST °("POST" "/p/albums.ua")
# | ⍩Example~GET °("GET" "/p/example.ua")
# | ⍩⍤"Invalid route."0
# )

Routes ← ⍣(
  ⍩Index~GET ⋅°"/"
| ⍩FileRoutes
)

Handle ← ⨬(
  "500 Internal Server Error" "text/plain" utf₈
| "404 Not Found" "text/plain" utf₈"Not Found"
)⊸≍"Invalid route."

Run‼(Routes|Handle)
