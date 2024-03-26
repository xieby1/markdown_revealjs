let
  pkgs = import <nixpkgs> {};
  revealjs_sh = import ./default.nix;
  my_python = pkgs.python3.withPackages (p: with p; [
    plotly
    pandas
    packaging
  ]);
in pkgs.mkShell {
  packages = [
    revealjs_sh
    my_python
    pkgs.html-minifier
  ];
}
