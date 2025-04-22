#!/usr/bin/env bash

set -e # exit on error

# kill children processes when exit
# https://aweirdimagination.net/2020/06/28/kill-child-jobs-on-script-exit/
cleanup() {
    pkill -P $$ || true # kill all processes whose parent is this process
}
for sig in INT QUIT HUP TERM; do
  trap "
    cleanup
    trap - $sig EXIT
    kill -s $sig "'"$$"' "$sig"
done
trap cleanup EXIT

TEMPLATE="$(dirname $(realpath --relative-to=. $0))/../share/markdown_revealjs/template.html"
INCLUDE_FILES="$(dirname $(realpath --relative-to=. $0))/../lib/lua-filters/include-files/include-files.lua"
INCLUDE_CODE_FILES="$(dirname $(realpath --relative-to=. $0))/../lib/lua-filters/include-code-files/include-code-files.lua"

DAEMONIZE=0
ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d)
      DAEMONIZE=1
      shift  # 跳过-d参数
      ;;
    *)
      ARGS+=("$1")  # 将其他参数加入数组
      shift
      ;;
  esac
done

MD=${ARGS[0]}

usage() {
    echo "Usage: ${0##*/}" convert markdown file to reveal.js slides.
    echo "[REPOROOT=<Path>] ${0##*/} [-h] [-d] <input.md> [pandoc args]"
    echo "  Use pandoc convert <input.md> to input.html."
    echo "  -d          daemonize"
    echo "  Environment variables:"
    echo "  REPOROOT    override the default markdown_revealjs url"
    echo "              E.g. if you want to play your slides offline,"
    echo "              set the REPOROOT to the local markdown_revealjs."
    echo "  PANDOC      override the default pandoc executable"
    echo "  Customized pandoc args:"
    echo "  -V lxgw     enable LXGW Wenkai font"
    exit 0
}

revealjs() {
if [[ -n ${REPOROOT} ]]; then
    echo REPOROOT is set as \"${REPOROOT}\"
else
    REPOROOT="https://xieby1.github.io/markdown_revealjs"
fi

if [[ -n ${PANDOC} ]]; then
    echo PANDOC is set as \"${PANDOC}\"
else
    PANDOC=pandoc
fi

if [[ $# -eq 0 || "$1" == "-h" || -z ${MD} ]]; then
  usage
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
        pandoc-opts)
            PANDOC_OPTS=${val}
        ;;
        esac
    fi
done < ${MD}

CMD=(
    # replace $reporoot-url$ with ${REPOROOT}
    "sed 's,\\\$reporoot-url\\\$,${REPOROOT},g' ${MD}"

    "|" # pipeline

    "${PANDOC}"
    "-t revealjs"
    "--template=${TEMPLATE}"
    "-V theme=white"
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
    "-o ${MD%.*}.html"
    "${PANDOC_OPTS}"
    "${@:2}"
)
if [[ $DAEMONIZE == 1 ]]; then
  CMD+=("-V daemonize")
fi

eval "${CMD[@]}"
# echo "${CMD[@]}"
}

if [[ $DAEMONIZE == 1 ]]; then
  browser-sync start -s $(dirname "$MD") -f "$MD" --index "${MD%.*}.html" &
  while true; do
    revealjs "${ARGS[@]}"
    inotifywait -e modify "$MD" || true
  done
else
    revealjs "${ARGS[@]}"
fi
