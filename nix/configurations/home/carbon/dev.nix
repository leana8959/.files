{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  home.packages = [
    # IDEs
    pkgs.vscode-fhs
    pkgs.jetbrains.idea-community

    # keyboard
    pkgs.clang-tools
    pkgs.qmk
    pkgs.wally-cli

    # golang
    pkgs.go
    pkgs.golangci-lint
    pkgs.gofumpt

    # typescript
    pkgs.typescript
    pkgs.nodejs_20
    pkgs.vscode-langservers-extracted # HTML/CSS/JSON/ESLint

    # rust
    pkgs.cargo
    pkgs.rustc
    pkgs.rustfmt

    # java
    pkgs.maven

    pkgs.gnumake
    pkgs.cmake

    pkgs.iconv
    pkgs.sqlite

    # isabelle
    myPkgs.isabelle-wrapped
    pkgs.hol
  ];

  programs.neovim.extraPackages = [
    # fish
    myPkgs.fish-lsp

    # golang
    pkgs.gopls
    pkgs.golangci-lint-langserver

    # typescript
    pkgs.nodePackages.typescript-language-server

    # rust
    pkgs.rust-analyzer

    # java
    pkgs.jdt-language-server
  ];

  programs.go = {
    enable = true;
    goPath = ".go";
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk17.override { enableJavaFX = true; };
  };
}
