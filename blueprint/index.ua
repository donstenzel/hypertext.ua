# Experimental!
~ "../html" ~ A! Div! Head! Html! H₁! H₂! Meta! P! Render

Html!() {
  Head!() {
    Meta!(charset → "UTF-8") {}
  }
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
