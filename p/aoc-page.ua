~ "../html"
  ~ A Body Code Div Escape Head Html
  ~ H₂ H₄ LI Link Meta Title UL
~ "../components" ~ HomeButton UiuaCode

View ← Html {
  Head {
    Title "Advent of Code Solutions"
    ⬚∘Link [
      {"rel" "icon"}
      {"type" "image/x-icon"}
      {"href" "/root/favicon.ico"}
    ] {}
    ⬚∘Meta [{"charset" "UTF-8"}] {}
  }

  HomeButton

  Body {
    ⬚∘H₂ [{"style" "text-align: center;"}]
    $ Advent of Code 2024 Solutions in Uiua!
    Div {
      UL ⍚(LI {⊃(H₄ $"Path: _"|UiuaCode Escape &fras)})
      ⍆▽⊸≡◇(≍".ua"↙₋₃)
      &fld "/home/bennet/uiua/aoc/2024/"
    }
  }
}

GET ← "200 OK" "text/html" utf₈ ⊂"<!DOCTYPE html>\n" View ◌
