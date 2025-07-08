# Experimental!
~ "http" ~ ExtMime Extension Request Response

E ← &p$"[Error] _\n"

# Responds to a single request with router / handler
Respond‼ ← ◌pool(
  &p$"Request by _"⊸⊃&tcpaddr Request
  &p⊃$"Method: _\nPath: _"⍣^0⋅⋅⋅⊃E^1
  ⊃⊓⧻&cl&w Response
  &p$"Response is _ bytes\n"
)

# Call this with a routing function and an
# error handler. The resulting function expects
# an ip address and a port: `? ip port`. The ip
# should be four numbers and the port a single number.
# The server will then run on the given address.
Run‼ ← (
  &tcpl $"_:_" /$"_._"
  ⍢(Respond‼^0^1 &tcpa)1
)

# saner version: now with semantic comment!

# Given a box array of files and/or directories,
# returns all files recursively.
# files ? { bases }
Files ← ⍥(/◇⊂⍚⨬&fld□⊸≡◇&fif)∞

# sanitized ? file base
SaneName ↚ ▽⟜⍜⊜□⍚⍜⊢⌵∊+@A⇡26⊸⌵˜⌝⊂°$"_.ua"

# methods routes fn-names ? source
Extract ↚ ◌≡°⊟₄ regex $ # Route! (GET|POST) ([a-zA-Z0-9/_]+)
                      $ (\w+) ←

# import ? path name
Import ↚ ˜$"_ ~ \"_\""
# patterns ? methods routes
Patterns ↚ ⍚(
  ⨬($"⊓°(\"_\")°(\"_\")"
  | $"⊓°(\"_\"){°($\"_\")}"
  )◡⋅(∊⊙@_)
)
# functions ? names module
Functions ↚ ⍚⌟˜$"_~_"
# arms ? pattern function
Arms ↚ ⍚˜$"⍩_ _"
# output ? imports routes
Fin ↚ ˜$$ _
       $$ 
       $$ Routes ← ⍣(
       $$   _
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
