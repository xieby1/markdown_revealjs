---
title: Markdown RevealJS
author: 🤓xieby1
date: 🎉2022.06.10
headerl: ↖️ header left
headerr: <a href="https://github.com/xieby1/markdown_revealjs"><img src="https://github.com/fluidicon.png" style="width:16pt;">Github Repo</a>
footerl: ↙️ footer left
footerr: by xieby1
---

# Intro

A Simple Easy Converter

<h2>Markdown ➡ Reveal.js</h2>

* Based on Pandoc
* Auto-generated TOC
* Touch-device friendly
* Header footer supported

## Demo

This README.md is converted to revealjs,
see it [here](https://xieby1.github.io/markdown_revealjs/README.html).

## How it works

Bash script + Template file + Pandoc

It's simple and esay!

# Installation

## Prebuilt Package

See [Releases](https://github.com/xieby1/markdown_revealjs/releases).

## Manual Installation

* First, [Install latest pandoc](https://github.com/jgm/pandoc).

  Note: Ubuntu 22's apt-installed pandoc is too old.

* Second,

  ```bash
  git clone https://github.com/xieby1/markdown_revealjs
  ln -s <path/to>/revealjs.sh /usr/bin/
  # or /usr/local/bin/, or ~/.local/bin/
  ```

## Build Packages

If you are interested in generating packages.

Packages are generated by nix script

`./build_packages.nix`.

🐱

The generated packages include

* static-linked pandoc
* revealjs.sh
* pandoc template

# Quick Start

## First Page

Add the metadata (title, author, date)

to top of your markdown file.

These info will become the first page of your slide.

```markdown
% markdown_revealjs !
% xieby1
% 2022.06.24
```

## Basic Syntax

| syntax           | meaning              |
| ---------------- | -------------------- |
| 1st-level header | New horizontal slide |
| 2nd-level header | New vertical slide   |

## Convert!

```bash
$ revealjs.sh <input.md>
# will generate input.html
```

🐱

It's simple and easy, right?

# Advanced Syntax

Sorted in alphabet.

# Backgrounds

TODO:

Did you notice that every page has a default background?

# Backgrounds {data-background-color="LightPink"}

* RevealJS: [backgrounds](https://revealjs.com/backgrounds/)
* Pandoc Extension: [header_attributes](https://pandoc.org/MANUAL.html#extension-header_attributes)

```markdown
# Backgrounds {data-background-color="LightPink"}
```

# Fragments

* RevealJS: [fragments](https://revealjs.com/fragments/)

## Multi Lines

::: {.fragment}
* Pandoc Extension: [fenced_divs](https://pandoc.org/MANUAL.html#extension-fenced_divs)
:::
::: {.fragment}
```markdown
::: {.fragment}
Your content here
:::
```
:::

## One Line

* Pandoc Extension: [bracketed_spans](https://pandoc.org/MANUAL.html#extension-bracketed_spans)

[It's in one line!]{.fragment}
[🐱]{.fragment}
[🐶]{.fragment}
[🐹]{.fragment}

:::{.fragment}
```
[It's in one line!]{.fragment}
[🐱]{.fragment}
[🐶]{.fragment}
[🐹]{.fragment}
```
:::

# Multiple columns

* Pandoc Extension: [fenced_divs](https://pandoc.org/MANUAL.html#extension-fenced_divs)
* Builtin CSS class: container and col

## Two-column Example

::: {.container}
:::: {.col}
It is two columns!

This is column 1
::::
:::: {.col}
This is column 2

```
::: {.container}
:::: {.col}
Column 1
::::
:::: {.col}
Column 2
::::
:::
```
::::
:::

You can add as many columns as possible.

# include files

``` {.include}
./included.md
```

# QnA

* Problems?
* tips?
* Advice?

New issue and pull request is welcome!
