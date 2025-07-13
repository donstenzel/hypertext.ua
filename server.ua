# Experimental!
~ "http" ~ ExtMime Extension Request Response

E ← &p$"Error: _"

# Configuration for the server.
#  - Address: 4 numbers ∊ [0, 255]
#  - Port: single number
# Optional:
#  - Cert: certificate data as string
#  - Key: private key for certificate
# cfg ? address port
~Cfg {Address Port Cert ← ∞|Key ← ∞} ∘
# TODO: add validator for address values in [0, 255]
# and cert/key type = string

# Responds to a single request with router / handler.
Respond‼ ← (
  &p⊸₂$"[_] _ _"⊸⊃&tcpaddr Request
  ⍤@◌¬≍□"close"◡⋅⋅⬚∞(get"Connection")
  &w Response ⍣^0⋅⋅⋅⋅⊃E^1
)
# TODO: better logging?

# Establishes a connection and handles requests
# synchronously on this connection.
Connect‼ ← (
  ◌ pool⍣⍢Respond‼^0^1 1 ⊃&cl(
    &p$"[_] Closing connection."&tcpaddr
  )⊸&tcpsrt 15 &tcpa
)

# This macro expects two functions:
# A function that represents your routes.
# A function that handles errors by your routes.
# The resulting function expects a config struct `Cfg`.
# The server will then run on the given address. If both
# certificate and private key are given, the server
# will use TLS. If they don't match or are invalid
# in some other way, there will be an error.
# The server can handle multiple connections
# concurrently, and handles requests on these
# synchronously.
Run‼ ← (
  ⍢Connect‼^0^1 1 ⨬&tcpl&tlsl Cfg!⊃(
    ×∩(¬≍∞)⊃Cert Key
  | $"_:_" /$"_._"⊃Address Port
  | Cert
  | Key
  )
)

# saner version: now with semantic comment!

# Given a box array of files and/or directories,
# returns all files recursively.
# files ? bases
Files ← ⍥(/◇⊂⍚⨬&fld□⊸≡◇&fif)∞

# sanitized ? file base
SaneName ↚ ▽⟜⍜⊜□⍚⍜⊢⌵∊+@A⇡26⊸⌵˜⌝⊂°$"_.ua"

# methods routes fn-names ? source
Extract ↚ ◌≡°⊟₄ regex $ # Route! (GET|POST) ([a-zA-Z0-9/_\-]+)
                      $ (\w+) ←

# import ? path name
Import ↚ ˜$"_ ~ \"_\""
# patterns ? methods routes
Patterns ↚ ⍚(
  ⨬($"⊓°(\"_\")°(\"_\")"    # no params in route
  | $"⊓°(\"_\"){°($\"_\")}" # with params
  )◡⋅(∊⊙@_)
)
# functions ? names module
Functions ↚ ⍚⌟˜$"_~_"
# arms ? patterns functions
Arms ↚ ⍚˜$"⍩_ _"
# output ? routes imports
Fin ↚ ˜$$ _
       $$ 
       $$ Routes ← ⍣(
       $$   _
       $$ | ⍤"No route declared"0
       $$ )

Make ↚ Fin ⊓/$"_\n| _" /$"_\n_" /◇⊂⍚(
  ⊃⊓&fras∘Import⟜SaneName
  Arms ⊓Patterns Functions Extract
)▽⊸≡◇(≍"ua"Extension)Files⊃□₁¤

# Call this macro with a string containing the root directory
# of a site you want to create routes for. Routes are declared
# by using a semantic comment: `# Route! [method] [route]`.
# The method must be one of GET or POST as of writing this,
# the route a string of letters and numbers, separated by
# slashes with optional underscores as placeholders.
# Placeholders will match any segment, and their values will be
# passed to the function. Defines a function `Routes` that
# matches the requests and delegates to relevant functions.
# When no placeholders are used, only the payload is passed.
MakeRoutes! ←^ Make ◇°$"\"_\""⊢

# Returns response data that represents a file.
# `valid` is a box array of files to serve directly.
# When `path` is a member of `valid`, that file is
# served.
# code type data ? valid "GET" path
Assets ← "200 OK"⊃ExtMime&frab↘₁⤙⊃⋅°"GET"𝄐(⍤"No asset declared"∊⊙□)
