#!/usr/bin/env bash

TEMPLATE="$(dirname $(realpath --relative-to=. $0))/revealjs_template.html"
MD=$1
REVEALJS="https://cdn.bootcdn.net/ajax/libs/reveal.js/4.3.1"
# use which pandoc
PANDOC_="$(dirname $(realpath --relative-to=. $0))/revealjs/pandoc"
if [[ -f ${PANDOC_} ]]
then PANDOC=${PANDOC_}
else PANDOC="pandoc"
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

CMD=(
    "${PANDOC}"
    "-t revealjs"
    "--template=${TEMPLATE}"
    "-V theme=white"
    "-V revealjs-url=${REVEALJS}"
    "-V width=1200"
    "-V height=700"
    "-V hash"
    "-V chalkboard"
    "-V touch=false"
    "--slide-level=2"
    # table of content
    "--toc"
    "--toc-depth=2"
    # number sections
    "-N"
    "${MD}"
    "-o ${MD%.*}.html"
    "${@:2}"
)

eval "${CMD[@]}"
# echo "${CMD[@]}"
