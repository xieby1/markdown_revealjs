let
  pkgs = import <nixpkgs> {};
  revealjs_sh = import ./default.nix;
in pkgs.mkShell {
  packages = [
    revealjs_sh
  ];
}
