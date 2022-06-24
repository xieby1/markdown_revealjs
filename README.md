% Markdown RevealJS
% 🤓xieby1
% 🎉2022.06.10

# Intro

A Simple Esay Converter

<h2>Markdown ➡ Reveal.js</h2>

* Based on Pandoc
* Auto-generated TOC
* Touch-device friendly

## Demo

This README.md is converted to revealjs,
see it [here](https://xieby1.github.io/markdown_revealjs/README.html).

## How it works

Bash script + Template file + Pandoc

It's simple and esay!

# Installation

## Prebuilt Package

See [Releases](https://github.com/xieby1/markdown_revealjs/releases).

The prebuilt package includes the official static-linked pandoc, revealjs.sh and template.
They are packaged by nix script `./build_packages.nix`.

If you want to use your own pandoc executable, see Manual Installation.

## Manual Installation

[Install latest pandoc](https://github.com/jgm/pandoc).

Note: Ubuntu 22 pandoc is too old.

```bash
git clone https://github.com/xieby1/markdown_revealjs
ln -s <path/to>/revealjs.sh /usr/bin/
# or /usr/local/bin/, or ~/.local/bin/
```

# Quick Start

## First Page

Add the metadata (title, author, date) to top of your markdown file.

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

It's simple and esay, right?

# Advanced Syntax and Examples

Sorted in alphabet.

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

# QnA

* Problems?
* tips?
* Advice?

New issue and pull request is welcome!
