# HYPERTEXT.ua

**HYPERTEXT.ua** contains various modules to build websites with Uiua.

Note that this is heavily work in progress.

### Library

[`server.ua`](server.ua) is an http server capable of receiving simple requests to
different pages.

```uiua
~ "git: github.com/donstenzel/hypertext.ua"
  ~ Server

Routes ← (...)

Error ← (...)

Server~Run‼(Routes|Error)
```

---

[`html.ua`](html.ua) contains functions to create HTML documents using Uiua code.
Some example use cases could be a page to show a database table, or creating a page
for every file in some directory. See [`website.ua`](website.ua) for inspiration.

To get started, import `Html` from the library. From there you can
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


[`lib.ua`](lib.ua) simply exposes the different modules.

### Example site

[`website.ua`](website.ua) contains things specific to an example website.
Each route inside of files in [`p`](p) is automatically added with a macro.

[`components.ua`](components.ua) are some custom tags used in the website.

[`database.ua`](database.ua) contains table schemas and exposes my Uiqlite fork
for pages using a database. The database used is [chinook.db](https://github.com/lerocha/chinook-database)

### Notes

Paths may be system specific for now, but it should be limited to things
related to the website example, not the library code.

Some of the macro stuff is kinda insane lol. I think some sort of interface
system would make this a lot nicer. If each page was just an implementation
of an interface, the server could just use the relevant functions by loading
the file as a concretization of the abstract module.