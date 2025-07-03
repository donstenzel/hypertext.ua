# Experimental!
~ "html.ua" ~ Body Button Div Head Html H₁ Label Script
~ "server" ~ Run‼

┌─╴Page
  GET! ← "200 OK" "text/html" utf₈ ⊂"<!DOCTYPE html>\n" ⋅^0
  New ← GET!(
    Html {
      Head ⬚∘Script [{"src" "https://unpkg.com/htmx.org@2.0.4"}] {}
      Body {
        H₁ "HTMX testing"
        Div {
          Label "Original content of first div"
          ⬚∘Button [
            {"hx-get" "/more"}
            {"hx-target" "#divMore"}
          ] "Load more"
        }
        ⬚∘Div [{"id" "divMore"}] {"Original content of second div"}
      }
    }
  )

  More ← GET!(
    Div {
      Label "New content of div"
    }
  )
└─╴

Routes ← ⍣(
  Page~New ⋅°"/"
| Page~More °("GET" "/more")
)

Run‼(Routes|"500 Internal Server Error" "text/plain" utf₈)
