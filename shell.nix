let
  pkgs = import <nixpkgs> {};
  my_python = pkgs.python3.withPackages (p: with p; [
    plotly
    pandas
    packaging
  ]);
in pkgs.mkShell {
  packages = [
    my_python
    pkgs.html-minifier
    pkgs.pandoc
  ];
}
