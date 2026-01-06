# { pkgs, stdenv, writeShellScript, pandoc, ... }:
let
  pkgs = import <nixpkgs> {};
in
builtins.derivation {
  name = "revealjs.sh";
  system = builtins.currentSystem;
  src = ./.;
  builder = pkgs.writeShellScript "revealjs_sh_builder" ''
    source ${pkgs.stdenv}/setup
    mkdir -p $out
    cp -r $src/{bin,share,lib,fonts} $out/

    chmod -R +w $out/bin
    echo sed -i 's,=pandoc,=${pkgs.pandoc}/bin/pandoc,g' $out/bin/revealjs.sh
    sed -i 's,=pandoc,=${pkgs.pandoc}/bin/pandoc,g' $out/bin/revealjs.sh
    chmod -R -w $out/bin
    chmod a+x $out/bin/revealjs.sh
  '';
}
