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

# this code is deranged

# files ? directory
Files ↚ |1 /◇⊂⍚(⨬Files□⊸&fif) &fld

# bound-names ? path
Bindings ↚ (
  ⊸≠@\n&fras
  ⊜⍣(⊓□◌°$"_ ← _"|□"")
  ▽±⊸≡◇⧻
)

# import-str ? mod-name path
Import ↚ $"_ ~ \"_\""

# route-str ? function mod-name path
Route ↚ $"⍩_~_ °(\"_\" \"/_\")"⤙⟜⊙◌

Routes ↚ $$ FileRoutes ← ⍣(
         $$   _
         $$ | ⍩⍤"Invalid route."0
         $$ )

# sanitized ? file base
SaneName ↚ ▽⟜⍜⊜□⍚⍜⊢⌵∊+@A⇡26⊸⌵˜⌝⊂°$"_.ua"

Pack ↚ /$"_\n| _"

# TODO: refine this a little. semantic comment
# seems the best to me: # Route!
# Call with directory which contains files with routes to add.
# Declares `FileRoutes` containing all routes
MakeRoutes! ←^ ◇(
  ⍚(⊃(Bindings
    | ⊃∩¤Import⤚SaneName)
    Pack⍚Route ▽⊸≡◇(/×>₀±)
  )⊃Files¤ °$$ "_"
  ⊓Pack/$"_\n_" ▽±⊸≡◇⧻
  ˜$"_\n\n_" Routes
)⊢
