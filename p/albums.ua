# Experimental!

~ "../database" ~ Execute!
~ "../html"
  ~ Div Form Head Html H₁
  ~ Input LI Meta UL

Albums ← Execute!(
  ⊂ Album Artist
| ⊏ Title → Album, Name → Artist
| ⍆ Name
)

&p Html {
  Head ⬚∘Meta [{"charset" "UTF-8"}] {}
  H₁ "Albums"
  UL ≡LI ≡⍚Div Albums
}
