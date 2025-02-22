# Experimental!

~ "../html"
  ~ Div Form H₁ H₂ Input
  ~ Head Html Meta
  ~ LI Option Select UL
~ "../database" ~ Album Artist DB Lib
~ "../components" ~ HomeButton
~ "../http" ~ ParseQuery

Albums ← (
  Lib!C!Values!(
    ⊂ Album Artist
  | ⊏ Title → Album, Name → Artist
  | ⍆ Title
  ) DB
)

Artists ← (
  Lib!C!Values!(
    ⊡ Artist
  | ⊏ Name, ArtistId
  | ⍆ Name
  ) DB
)

# ? {title artistId}
AddAlbum ← (
  Lib!C!ExecFmt!(
    + Album (Title, ArtistId)
  | ⍚[($t, $a)]
  ) DB
)

View ← (
  ⊂"<!DOCTYPE html>\n" Html {
    Head ⬚∘Meta [{"charset" "UTF-8"}] {}
  
    HomeButton
  
    H₁ "Albums"
    ⬚∘UL [{"style" "overflow-y: scroll; max-height: 50vh;"}]
    ⍚LI ≡⍚Div Albums
  
    Div {
      H₂ "Add new album"
      ⬚∘Form [{"method" "post"} {"action" "/p/albums.ua"}] {
        Div □₂
        $ Artist:
        ⬚∘Select [{"name" "ArtistId"}]
        ⍚(⬚∘Option⊃[{"value" ⊣}]⊢) Artists
      
        Div □₂
        $ Album name:
        ⬚∘Input [{"name" "Title"}] {}
      
        ⬚∘Input [{"type" "submit"}] {}
      }
    }
  }
)

# [ROUTE] ← semantic comment? like a c# attribute
GET ← "200 OK" "text/html" utf₈ View ◌

POST ← "200 OK" "text/html" utf₈ View AddAlbum get{"Title" "ArtistId"} ParseQuery
