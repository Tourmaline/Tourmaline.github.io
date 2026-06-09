---
layout: post
title: "Hello, World"
date: 2026-06-09
tags: [meta]
---

This is the first note on this site. The academic PhD work lives at [/phd/](/phd/) —
this space is for rougher, shorter notes: things I am learning, tools I find useful,
ideas worth writing down before they disappear.

## What this site is for

The PhD site covers research, publications, and teaching. This section is for
everything else:

- Numerical methods I want to remember
- Small programming experiments
- Reading notes
- Anything that doesn't fit a paper

## How to add a new note

Drop a `.md` file in `_posts/` named `YYYY-MM-DD-title.md` with this front matter:

```yaml
---
layout: post
title: "Your Title"
date: 2026-06-09
tags: [optional, tags]
---
```

Then write the note in Markdown below the `---`. GitHub Pages builds and deploys it
automatically — no extra steps needed.

## Markdown basics

A quick reference for the things I use most:

**Text formatting**: `**bold**`, `*italic*`, `` `inline code` ``

**Links**: `[link text](https://example.com)`

**Code blocks** with syntax highlighting — just specify the language:

```python
def hello(name: str) -> str:
    return f"Hello, {name}!"
```

```matlab
x = linspace(0, 2*pi, 100);
plot(x, sin(x));
```

**Math** (if needed, use a `_includes/mathjax.html` snippet with MathJax or KaTeX):

> Inline: `$E = mc^2$` — block equations with `$$...$$`

That's it. The workflow is intentionally minimal.
