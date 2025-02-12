# HYPERTEXT.ua

**HYPERTEXT.ua** contains various components to build websites with Uiua.

---

[`server.ua`](server.ua) is an http server capable of receiving simple requests to 
different pages.

```uiua
~ "git: github.com/donstenzel/hypertext.ua"
  ~ Server

Routes ← (...)

Server~Run!Routes
```

---

[`html.ua`](html.ua) contains logic to create HTML documents using Uiua syntax.
This also allows you to use Uiua code to generate pages based on files and stuff.

To get started with this, import `Html` from the library. From there you can
use the tags inside the module.

Here's what a random div with a codeblock and a link looks like:
```uiua
Div {
  ⬚∘A [{"href" "/some/page.html"}] "Link!"

  Code $ def add(x, y):
       $   return x + y
}
```

Attributes are optionally given via `⬚ fill`, as seen in the example.

---

[`utils.ua`](utils.ua) holds a couple of functions which are used across files,
or don't really belong to any other component.


[`lib.ua`](lib.ua) simply exposes the server, html generation and utils.


[`website.ua`](website.ua) contains things specific to the website,
not intended for outside usage beyond being an example.


[`database.ua`](database.ua) contains table schemas and a helper function
for pages using the database.