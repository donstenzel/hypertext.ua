# Experimental!

~ "../html"
  ~ Div Form H₁ H₂ Input
  ~ Head Html Meta
  ~ LI Option Select UL
~ "../database" ~ Album Artist DB Uiqlite
~ "../components" ~ HomeButton
~ "../http" ~ ParseQuery

Albums ← (
  Uiqlite~Query~Values!(
    ⊂ Album Artist
  | ⊏ Title → Album, Name → Artist
  | ⍆ Title
  ) DB
)

Artists ← (
  Uiqlite~Query~Values!(
    ⊡ Artist
  | ⊏ Name, ArtistId
  | ⍆ Name
  ) DB
)

# ? {title artistId}
AddAlbum ← (
  Uiqlite~Query~ExecFmt!(
    + Album (Title, ArtistId)
  | ⍚[(’$t’, $a)]
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

GET ← "200 OK" "text/html" utf₈ View ◌

POST ← "200 OK" "text/html" utf₈ View AddAlbum get{"Title" "ArtistId"} ParseQuery
