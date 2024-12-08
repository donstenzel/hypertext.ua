# HYPERTEXT

**HYPERTEXT** is my personal website project.

[`server.ua`](server.ua) is an http server capable of receiving simple requests to different pages.
Pages are generated at runtime using the `html.ua` library.

[`html.ua`](html.ua) contains logic to create HTML documents using Uiua syntax.
This also allows you to use Uiua code to generate pages based on files and stuff.

To use it, simply import tag macros like so:
```uiua
~ "hypertext.ua"
  ~ Div!
```

[`generator.ua`](generator.ua) can be used to generate a static website from
a given directory tree.

To generate something import `MakeSkel` and `Generate` from here.

[`fns.ua`](fns.ua) just holds a couple of functions which are used across files.

