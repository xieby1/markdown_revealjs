#!/usr/bin/env nix-build
{
  pkgs ? import <nixpkgs> {}
}:
let
  NAME = "markdown_revealjs";
  package_platform = _pltfm : _vrsn : _hsh: pkgs.stdenv.mkDerivation {
    name = "${NAME}";
    srcs = [
      (builtins.path {
        name = "${NAME}";
        path = ./.;
      })
      (builtins.fetchTarball {
        name = "prebuilt_pandoc";
        url = "https://github.com/jgm/pandoc/releases/download/${_vrsn}/pandoc-${_vrsn}-${_pltfm}.tar.gz";
        sha256 = "${_hsh}";
      })
        # --license agpl3
        # --version 0.1.0
      ( builtins.toFile ".fpm" ''
        -s dir
        --name ${NAME}
        --architecture all
        --depends bash
        --description "Markdown to Reveal.js Slides Converter"
        --url "https://github.com/xieby1/markdown_revealjs"
        --maintainer "xieby1 <xieby1@outlook.com>"
        ${NAME}/bin/revealjs.sh=/usr/bin/revealjs.sh
        ${NAME}/share/markdown_revealjs/template.html=/usr/share/markdown_revealjs/template.html
        ${NAME}/share/markdown_revealjs/include-files.lua=/usr/share/markdown_revealjs/include-files.lua
        ${NAME}/share/markdown_revealjs/include-code-files.lua=/usr/share/markdown_revealjs/include-code-files.lua
        prebuilt_pandoc/bin/pandoc=/usr/share/markdown_revealjs/pandoc
      '')
    ];
    sourceRoot = ".";
    unpackCmd = "cp $curSrc ./.fpm";
    buildInputs = [
      pkgs.fpm
    ];
    installPhase = ''
      mkdir -p $out
      fpm -t deb -p $out/${NAME}-${_pltfm}.deb
    '';
  };
in
{
  revealjs_linux_amd64 = package_platform "linux-amd64" "2.18" "1wzyldscnb88f5bjbwx8hh110xi5avqbr9pyn7swq29b6qaans33";
  revealjs_linux_arm64 = package_platform "linux-arm64" "2.18" "0f7vfjx10y211hiywgb2lc6w2r8xk12zxp1v248j6n2vsa8v2i2w";
}
