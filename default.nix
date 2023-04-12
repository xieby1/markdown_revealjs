# { pkgs, stdenv, writeShellScript, pandoc, ... }:
let
  pkgs = import <nixpkgs> {};
in
builtins.derivation {
  name = "revealjs.sh";
  system = builtins.currentSystem;
  src = ./revealjs.sh;
  template = ./revealjs_template.html;
  include_files = ./include-files.lua;
  builder = pkgs.writeShellScript "revealjs_sh_builder" ''
    source ${pkgs.stdenv}/setup
    mkdir -p $out/bin
    dst=$out/bin/revealjs.sh
    cp $src $dst
    cp $template $out/bin/revealjs_template.html
    cp $include_files $out/bin/include-files.lua
    chmod +w $dst
    sed -i 's,"pandoc",${pkgs.pandoc}/bin/pandoc,g' $dst
    chmod -w $dst
    chmod a+x $dst
  '';
}
