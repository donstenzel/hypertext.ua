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
  ⬚∘A {"href" "/some/page.html"} "Link!"

  Code $ def add(x, y):
       $   return x + y
}
```

Attributes are optionally given via `⬚ fill`, as seen in the example.

---

[`http.ua`](http.ua) contains request/response and parsing related functions.


[`lib.ua`](lib.ua) simply exposes the different modules.

### Example site

An example site can be found [here](https://github.com/donstenzel/htua-example).
