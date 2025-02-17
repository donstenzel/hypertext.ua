~ "../html"
  ~ A Button Code Div Escape
  ~ Head Html H₁ H₂ H₃ H₄ 
  ~ Meta P Sample Style
~ "../components" ~ HomeButton UiuaCode

View ← Html {
  Head ⬚∘Meta [{"charset" "UTF-8"}] {}

  HomeButton

  ⬚∘H₁ [{"style" "text-align: center;"}] "Uiua HTML Generation"
  Div {
    ⬚∘H₃ [{"style" "text-align: center;"}] "Overview"
  
    ⬚∘P [{"style" "white-space: pre;"}]
    $ This library allows you to write html using uiua code.
    $ You can easily create static pages with this.
  
    ⬚∘P [{"style" "white-space: pre; line-height: 1"}] {
      $ An example could look like:
      UiuaCode
      $ &p Html {
      $   Head ⬚∘Meta [{"charset" "UTF-8"}] {}
      $   
      $   H₁ "Uiua website"
      $   Div {
      $     $ This website is generated from a small library called
      $     ⬚∘A [{"href" "/p/example.ua"}] "hypertext.ua!"
      $   }
      $ }
    
      $ This would then emit:
      Sample Escape
      $ <html>
      $   <head>
      $     <meta charset="UTF-8">
      $   </head>
      $   <h1>
      $     Uiua website
      $   </h1>
      $   <div>
      $     This website is generated from a small library called
      $     <a href="/p/example.ua">
      $       hypertext.ua!
      $     </a>
      $   </div>
      $ </html>
    }
  
    ⬚∘P [{"style" "white-space: pre"}]
    $ Note that the contents of each tag are entirely up to you.
    $ They can be regular strings or a list of other tags that are implemented.
    $ It is important to note that tags are turned into html eagerly.
  
    ⬚∘P [{"style" "white-space: pre"}] {
      $ Attributes are supplied by setting a fill value on a tag.
      $ This can be used with Identity to get the usual order of things:
      UiuaCode $ ⬚∘Tag [{"attribute" "value"} ...] { Content }
    
      $ You can easily create simple custom tags like the UiuaCode tag inside the
      $ library. It automatically applies the Uiua386 font to a code block,
      $ while still allowing further attributes.
    }
  }
  ⬚∘Div [{"style" "text-align: center;"}] {
    H₃ "Check this stuff out!"
    H₄ ⬚∘A [{"href" "https://www.github.com/donstenzel/html.ua"}] "Source code"
    H₄ ⬚∘A [{"href" "https://www.github.com/donstenzel"}] "My GitHub"
  }
}

GET ← "200 OK" "text/html" utf₈ ⊂"<!DOCTYPE html>\n" View ◌
