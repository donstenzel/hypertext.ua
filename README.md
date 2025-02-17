# HYPERTEXT.ua

**HYPERTEXT.ua** contains various components to build websites with Uiua.

### Library

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

[`http.ua`](http.ua) contains request/response and parsing related functions.


[`utils.ua`](utils.ua) holds a couple of functions which are used across files,
or don't really belong to any other component.


[`lib.ua`](lib.ua) simply exposes the server, html generation and utils.

### Example site

[`website.ua`](website.ua) contains things specific to an example website.


[`database.ua`](database.ua) contains table schemas and exposes my Uiqlite fork
for pages using a database. The database used is [chinook.db](https://github.com/lerocha/chinook-database)

[`components.ua`](components.ua) are some custom tags used in the website.


### Notes

Paths may be system specific for now, but it should be limited to things
related to the website example, not the library code.

Some of the macro stuff is kinda insane lol. I think some sort of interface
system would make this a lot nicer. If each page was just an implementation
of an interface, the server could just use the relevant functions by loading
the file as a concretization of the abstract module.