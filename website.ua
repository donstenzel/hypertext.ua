# Experimental!
~ "server" ~ MakeRoutes! Run‼

# this generates routes
MakeRoutes!"p"

Routes ← ⍣(
  ⍩Index~GET ⋅°"/"
| ⍩FileRoutes
)

Handle ← ⨬(
  "500 Internal Server Error" "text/plain" utf₈
| "404 Not Found" "text/plain" utf₈"Not Found"
)⊸≍"Invalid route."

Run‼(Routes|Handle)
