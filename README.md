---
title: Markdown RevealJS
author: <img src="./images/me.png" style="height:1.5em;">xieby1
date: 🎉2022.06.10
headerl: <img src="./images/me.png" style="height:1.5em;">
headerr: <a href="https://github.com/xieby1/markdown_revealjs"><img src="https://github.com/fluidicon.png" style="width:16pt;">Github Repo</a>
footerl: ↙️ by xieby1

title-slide-background-image: ./images/liquid-cheese.svg
toc-slide-background-image: ./images/liquid-cheese.svg
level1-slide-background-image: ./images/liquid-cheese.svg
level2-slide-background-image: ./images/liquid-cheese_shallow.svg

toc-depth: 1
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

# Alignment

All elements

in Reveal.JS

are centered

by default.

😺

## Left Alignment

:::{style="display:inline-block; text-align:left;"}
If you prefer to left align

all children elements.

Add these styles

to the parent element.

😽

```md
:::{style="display:inline-block; text-align:left;"}
things here are all

left aligned

!
:::
```
:::

# Backgrounds

Did you notice that every page has a default background?

## Default Backgrounds

Set default backgrounds in yml front matter, like

```yml
title-slide-background-image: <URL>
toc-slide-background-image: <URL>
level1-slide-background-image: <URL>
level2-slide-background-image: <URL>
```

## Per-Slide Backgrounds {data-background-color="LightPink"}

Set per-slide background, like

```markdown
# Per-Slide Backgrounds {data-background-color="LightPink"}
```

More info about background see:

* RevealJS: [backgrounds](https://revealjs.com/backgrounds/)
* Pandoc Extension: [header_attributes](https://pandoc.org/MANUAL.html#extension-header_attributes)


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

# Include Files

## include files normally

``` {.include}
./included.md
```

More details: https://github.com/pandoc/lua-filters/blob/master/include-files/include-files.lua

## include files in code block

~~~
``` {include="./helloworld.c"}
```
~~~

``` {.c include="./helloworld.c"}
```

More details: https://github.com/pandoc/lua-filters/blob/master/include-code-files/include-code-files.lua

## example: Chart.js

::: {.container}
:::: {.col}

include a chart.js plot

~~~
``` {.include}
./plots/bar.html
```
~~~

::::
:::: {.col}

``` {.include}
./plots/bar.html
```

::::
:::

# Math

Write latex math equation like this

```latex
$$
F = G \frac{m_1 \times m_2}{R^2}
$$
```

$$
F = G \frac{m_1 \times m_2}{R^2}
$$

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

# Third Level

## This is a second-level title

This second-level slide contains two third-level slides

which is achieved by `---`

---

<h3>Third-Level Slide1</h3>

Miao~

---

<h3>Third-Level Slide2</h3>

Wang!

# QnA

* Problems?
* tips?
* Advice?

New issue and pull request is welcome!
