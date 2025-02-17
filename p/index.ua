~ "../html"
  ~ A Div Form Head Html
  ~ H₁ H₂ Input Meta P

View ← Html {
  Head ⬚∘Meta [{"charset" "UTF-8"}] {}

  H₁ "Uiua website"
  Div {
    $ This website is generated from a small library called
    ⬚∘A [{"href" "/p/example.ua"}] □$ hypertext.ua!
  }

  Div {
    $ Here's a page containing my
    ⬚∘A [{"href" "/p/aoc-page.ua"}] □$ 2024 AoC Solutions.
  }

  Div {
    $ And
    ⬚∘A [{"href" "/p/albums.ua"}] □$ here's
  
    $ a page which loads Albums from a database.
    $ At the bottom you can add new albums. (not yet)
  }
}

GET ← "200 OK" "text/html" utf₈ ⊂"<!DOCTYPE html>\n" View ◌
