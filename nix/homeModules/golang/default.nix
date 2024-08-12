{ pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = ".go";
  };

  home.packages = [
    pkgs.go
    pkgs.gopls
    pkgs.golangci-lint
    pkgs.golangci-lint-langserver
    pkgs.gofumpt
  ];
}
