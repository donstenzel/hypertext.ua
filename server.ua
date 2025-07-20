# Experimental!
~ "http" ~ Extension Mime Request Response

# Nicely formatted timestamp.
# time ?
Time ↚ (
  ⍜⊙⊏₃+timezone datetime now
  ⍜↙₋₃⍚⬚⌞@0⍜⧻⋅2°⋕
  °[°$"_-_-_ _:_:_"]
)

┌╶╶E
  # ? message
  Connection ← &p $"[@ _] Error establishing connection: _" Time

  # ? message socket
  Response ← &p $"[_ @ _] Error responding: _" ⊓&tcpaddr Time
└╶╶

┌╶╶V
  File    ← ⍤$"File does not exist: _"⤙⨬1&fe¬⊸≍∞
  Byte    ← ⍤$"Not a valid byte: _"⤙∊⇡256
  Address ← ⊃(⍤"Must be four bytes."=₄⧻|≡Byte)
  Port    ← °0type
└╶╶

# Configuration for the server.
#  - Address: 4 numbers ∊ [0, 255]
#  - Port: single number
# Optional:
#  - Cert: certificate path
#  - Key: private key path
# cfg ? address port
~Cfg {Address: V~Address|Port: V~Port|Cert: V~File ← ∞|Key: V~File ← ∞} ∘

# Responds to a single request with router / handler.
Respond‼ ← (
  &p⊸₂$"[_ @ _] _ _"⊙Time⊸⊃&tcpaddr Request
  ⍤@◌¬≍□"close"◡⋅⋅⬚∞(get"Connection")
  &w Response ⍣⊓^0∘⋅⋅⋅⋅⊃⋅^1⤚E~Response
)

# Establishes a connection and handles requests
# synchronously on this connection.
Connect‼ ← (
  ◌ pool⍣⍢Respond‼^0^1 1 ⊃&cl(
    ⊓&tcpaddrTime
    &p$"[_ @ _] Closing connection."
  )⊸&tcpsrt 30 &tcpa
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
  ⨬&tcpl&tlsl Cfg!⊃(
    ×∩(¬≍∞)⊃Cert Key
  | $"_:_" /$"_._"⊃Address Port
  | ∩(⍥&fras¬⊸≍∞) ⊃Cert Key
  )

  ⍢⍣⟜Connect‼^0^1⊙E~Connection 1
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
# NOTE: routes must be defined at the top level of a file.
MakeRoutes! ←^ Make ◇°$"\"_\""⊢

# Returns response data that represents a file.
# `valid` should be a box array of files to serve directly.
# When `path` is a member of `valid`, that file is served.
# Relative paths on a server will be routed as `/.../...`
# so remember that all paths must start with a slash,
# unlike the actual file paths. You can simply `⍚⊂@/`
# after collecting the actual file paths.
# code type data ? valid GET path
Assets ← (
  ⊃Mime&frab↘₁⤙⊃⋅°"GET"𝄐(⍤"No asset declared"∊⊙□)
  "200 OK" map∩□"Content-Type"
)
