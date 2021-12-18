% Markdown RevealJS
% 🤓xieby1
% Convert markdown file to reveal.js slides by pandoc. [Demo](https://xieby1.github.io/markdown_revealjs/README.html)

# Intro

## Demo

```
 ____  _____ __  __  ___
|  _ \| ____|  \/  |/ _ \
| | | |  _| | |\/| | | | |
| |_| | |___| |  | | |_| |
|____/|_____|_|  |_|\___/
```

Click: [Demo](https://xieby1.github.io/markdown_revealjs/README.html) to see demo hosted on Github pages.

## Prerequisite

* shell<img src="https://www.emojiall.com/img/platform/wechat/wx035.png" style="height: 1em;" />
* pandoc

## Install

```bash
git clone https://github.com/xieby1/markdown_revealjs
ln -s <path/to>/revealjs.sh /usr/bin/
# or /usr/local/bin/, or ~/.local/bin/
```

# Usage

## Basic

`cheatsheet.sh` convert <.md> to <revealjs.html>.

```bash
revealjs.sh <input.md>
# output: xxx.html
```

## Special syntax

Following markdown syntax are special:

| syntax           | meaning              |
| ---------------- | -------------------- |
| 1st-level header | New horizontal slide |
| 2nd-level header | New vertical slide   |

## Print

Refers to [revealjs: PDF Export](https://revealjs.com/pdf-export/)

Append `?print-pdf` to your URL.

## Local revealjs

Default revealjs version is 3.9.2 from cloudflare.

If want to use local revealjs, use `-l <path/to/revealjs>`

# Thanks

QnA

🙋🙋🙋
