# Experimental!
~ "../html" ~ A! Div! Html! H₁! H₂! P! Render

Html!() {
  H₁!() {"My personal website!"}
  Div!() {
    P!() {
      $ This website is generated from a small library
      $ called 
      A!(href → "/example.html") {"html.ua"}
      $ !
    }
  }
}

Render
