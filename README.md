% Markdown RevealJS
% 🤓xieby1
% 🎉2022.06.10

# Intro

A Simple Esay Converter

Markdown ➡ Reveal.js

based on Pandoc

## Demo

This README.md is converted to revealjs,
see it [here](https://xieby1.github.io/markdown_revealjs/README.html).


# Usage

It's simple and esay!

## Install


```bash
git clone https://github.com/xieby1/markdown_revealjs
ln -s <path/to>/revealjs.sh /usr/bin/
# or /usr/local/bin/, or ~/.local/bin/
```

Besides, you need to install pandoc.

## Convert

```bash
$ revealjs.sh <input.md>
# will generate input.html
```

For more usage info, see

```bash
revealjs.sh -h
```

# Special syntax

Here are special syntax for markdown_revealjs.

## Headings

| syntax           | meaning              |
| ---------------- | -------------------- |
| 1st-level header | New horizontal slide |
| 2nd-level header | New vertical slide   |

## Multiple columns

::: {.container}
:::: {.col}
By leveraging pandoc's

`fenced_divs` extension

See example on the right
::::
:::: {.col}
```
::: {.container}
:::: {.col}
Column 1
::::
:::: {.col}
Column 2
::::
:::: {.col}
...
::::
:::
```
::::
:::

## bracketed_spans

Bracketed_spans is able to add attr to spans.

For exampe, [this is a span with fragment.]{.class key="val" .fragment}

[🐱]{.fragment}
[🐶]{.fragment}
[🐹]{.fragment}

# More tips

For more tips,

see my revealjs cheatsheet

[xieby1.github.io/cheatsheet.html#revealjs](https://xieby1.github.io/cheatsheet.html#revealjs)
