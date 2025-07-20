# Experimental!
~ "html.ua" ~ Body Button Div Head Html H₁ Label Script
~ "server" ~ Cfg Run‼

┌─╴Page
  GET! ← "200 OK" map∩□"Content-Type" "text/html" utf₈⋅⋅^0
  New ← GET!(
    Html {
      Head ⬚∘Script {"src" "https://unpkg.com/htmx.org@2.0.4"} {}
      Body {
        H₁ "HTMX testing"
        Div {
          Label "Original content of first div"
          ⬚∘Button [
            {"hx-get" "/more"}
            {"hx-target" "#divMore"}
          ] "Load more"
        }
        ⬚∘Div {"id" "divMore"} {"Original content of second div"}
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

Cfg 0_0_0_0 8000
Run‼(Routes|"500 Internal Server Error" "text/plain" utf₈)
