{
  pkgs,
  mypkgs,
  unstable,
  ...
}: {
  home.packages = let
    utils = with pkgs; [
      hyperfine
      watchexec
      tea
      tokei
      gnumake
    ];

    lsps = with pkgs; [
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      shellcheck
      nodePackages.bash-language-server
      marksman
      nodePackages.pyright
      taplo
      nodePackages.vim-language-server
      lua-language-server
      fnlfmt
    ];

    nix = with pkgs; [
      nil
      alejandra
    ];

    pythonToolchain = [
      (pkgs.python39.withPackages (ps:
        with ps; [
          beautifulsoup4
          requests

          python-lsp-server
          rope
          pyflakes
          mccabe
          pycodestyle
          pydocstyle
          autopep8
        ]))
    ];
  in
    [
      # University stuff
      unstable.opam
      unstable.cargo
      mypkgs.logisim-evolution
      pkgs.rars
    ]
    ++ utils
    ++ lsps
    ++ nix
    ++ pythonToolchain;
}
