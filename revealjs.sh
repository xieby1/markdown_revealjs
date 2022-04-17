#!/usr/bin/env bash

TEMPLATE="$(dirname $(realpath $0))/template.html"
HEADER=$(dirname $(realpath $0))/head.html
MD=$1
REVEALJS_REMOTE="https://cdn.bootcdn.net/ajax/libs/reveal.js/4.3.1"

usage()
{
    echo "Usage: ${0##*/}" convert markdown file to reveal.js slides.
    echo "${0##*/} [-h] [-l <path/to/revealjs>] <input.md>"
    echo "  Use pandoc convert <input.md> to input.html."
    exit 0
}

while [[ ${OPTIND} -le $# ]]
do
    getopts "hl:" opt
    case "${opt}" in
        h)
            usage
            ;;
        l)
            REVEALJS_LOCAL=${OPTARG}
            ;;
        ?)
            MD=${!OPTIND}
            shift
            ;;
        *)
            echo "unknown arg${OPTIND} ${OPTARG}"
            exit 1
            ;;
    esac
done

if [[ -z ${MD} ]]
then
    echo "No inpurt markdown"
    usage
fi

if [[ -n ${REVEALJS_LOCAL} ]]
then
    #echo "${MD%/*} ${REVEALJS_LOCAL}"
    REVEALJS=$(realpath --relative-to="$(dirname ${MD%/*})" "${REVEALJS_LOCAL}")
else
    REVEALJS=${REVEALJS_REMOTE}
fi

CMD=(
    "pandoc"
    "-t revealjs"
    "--template=${TEMPLATE}"
    "-V theme=white"
    "-V revealjs-url=${REVEALJS}"
    "-V width=1200"
    "-V height=700"
    "-V hash"
    "-H  ${HEADER}"
    "--slide-level=2"
    # table of content
    "--toc"
    "--toc-depth=2"
    # number sections
    "-N"
    "${MD}"
    "-o ${MD%.*}.html"
)

eval "${CMD[@]}"
