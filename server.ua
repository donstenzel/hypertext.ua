# Experimental!
~ "http" ~ Request Response

Respond‼ ← ◌pool(
  &p$"Request by _"⊸⊃&tcpaddr Request
  &p⊃$"Method: _\nPath: _"⍣^0⋅⋅⋅^1
  ⊃⊓⧻&cl&w Response
  &p$"Response is _ bytes\n"
)

E ← &p$"[Error] _\n"

Run‼ ← (
  &tcpl "0.0.0.0:8000"
  ⍢(⍣Respond‼^0^1⋅E &tcpa)1
)

# saner version: now with semantic comment!

# files ? directory
Files ↚ ⍥(/◇⊂⍚⨬&fld□⊸≡◇&fif)∞ □₁

# sanitized ? file base
SaneName ↚ ▽⟜⍜⊜□⍚⍜⊢⌵∊+@A⇡26⊸⌵˜⌝⊂°$"_.ua"

# methods routes fn-names ? source
Extract ↚ ◌≡°⊟₄ regex $ # Route! (GET|POST) ([a-zA-Z0-9/_]+)
                      $ (\w+) ←

# import ? path name
Import ↚ ˜$"_ ~ \"_\""
# patterns ? methods routes
Patterns ↚ ⍚$"⊓°(\"_\"){°($\"_\")}"
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
)⊃Files¤

# Call this macro with a string containing the root directory
# of a site you want to create routes for. Routes are declared
# by using a semantic comment: `# Route! [method] [route]`.
# The method must be one of GET or POST as of writing this,
# the route a string of letters and numbers, separated by
# slashes with optional underscores as placeholders.
# Placeholders will match any segment, and their values will be
# passed to the function. TODO: no placeholder → no empty box array
Make! ←^ Make ◇°$"\"_\""⊢
