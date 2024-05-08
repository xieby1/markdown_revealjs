#!/usr/bin/env bash

TEMPLATE="$(dirname $(realpath --relative-to=. $0))/../share/markdown_revealjs/template.html"
INCLUDE_FILES="$(dirname $(realpath --relative-to=. $0))/../share/markdown_revealjs/include-files.lua"
INCLUDE_CODE_FILES="$(dirname $(realpath --relative-to=. $0))/../share/markdown_revealjs/include-code-files.lua"
MD=$1
REPOROOT="https://xieby1.github.io/markdown_revealjs"
REVEALJS="https://xieby1.github.io/markdown_revealjs/reveal.js"
# use which pandoc
PANDOC_="$(dirname $(realpath --relative-to=. $0))/../share/markdown_revealjs/pandoc"
if [[ -f ${PANDOC_} ]]
then PANDOC=${PANDOC_}
else PANDOC=pandoc
fi


if [[ $# -eq 0 || "$1" == "-h" || -z ${MD} ]]
then
    echo "Usage: ${0##*/}" convert markdown file to reveal.js slides.
    echo "${0##*/} [-h] <input.md> [pandoc args]"
    echo "  Use pandoc convert <input.md> to input.html."
    echo "  Customized pandoc args:"
    echo "  -V lxgw     enable LXGW Wenkai font"
    exit 0
fi

# get options from front matter in MD
tripleDash=0
while read -r line; do
    if [[ ${line} =~ ^--- ]]; then
        tripleDash+=1
        continue
    fi

    if [[ ${tripleDash} -gt 1 ]]; then
        break
    elif [[ ${tripleDash} -eq 1 ]]; then
        opt=${line%%:*}
        val=${line##*:}
        # remove leading spaces
        val=$(echo ${val})

        case ${opt} in
        toc-depth)
            TOC_DEPTH=${val}
        ;;
        esac
    fi
done < ${MD}

CMD=(
    "${PANDOC}"
    "-t revealjs"
    "--template=${TEMPLATE}"
    "-V theme=white"
    "-V revealjs-url=${REVEALJS}"
    "-V reporoot-url=${REPOROOT}"
    "-V width=1200"
    "-V height=700"
    "-V hash"
    "-V chalkboard"
    "-V touch=false"
    "-V simplemenu"
    "-V menu"
    "-V verticator"
    "-V showSlideNumber=all"
    "-V slideNumber='c/t'"
    "--slide-level=6"
    # table of content
    "--toc"
    "--toc-depth=${TOC_DEPTH:=2}"
    # number sections
    "-N"
    # include files
    "-L" "${INCLUDE_FILES}"
    # include cide files
    "-L" "${INCLUDE_CODE_FILES}"
    "--mathjax"
    "${MD}"
    "-o ${MD%.*}.html"
    "${@:2}"
)

eval "${CMD[@]}"
# echo "${CMD[@]}"
