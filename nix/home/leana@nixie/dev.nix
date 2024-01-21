{
  pkgs,
  mypkgs,
  ...
}: {
  home.packages = with pkgs; let
    # TODO: potentially break these into files
    haskellToolchain = let
      # credit: https://docs.haskellstack.org/en/stable/nix_integration/#using-a-custom-shellnix-file
      # need to match Stackage LTS version from stack.yaml resolver
      hPkgs = pkgs.haskell.packages.ghc947;

      # Wrap Stack to work with our Nix integration. We don't want to modify
      # stack.yaml so non-Nix users don't notice anything.
      # -no-nix: We don't want Stack's way of integrating Nix.
      # --system-ghc    # Use the existing GHC on PATH (will come from this Nix file)
      # --no-install-ghc  # Don't try to install GHC if no matching GHC found on PATH
      stack-wrapped = pkgs.symlinkJoin {
        name = "stack"; # will be available as the usual `stack` in terminal
        paths = [pkgs.stack];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/stack \
            --add-flags "\
              --no-nix \
              --system-ghc \
              --no-install-ghc \
            "
        '';
      };
    in [
      stack-wrapped
      hPkgs.ghc # GHC compiler in the desired version (will be available on PATH)
      hPkgs.stylish-haskell # Haskell formatter
      hPkgs.hoogle # Lookup Haskell documentation
      hPkgs.haskell-language-server # LSP server for editor
      hPkgs.cabal-install
    ];

    utils = [
      hyperfine
      watchexec
      tea
      tokei
      gnumake
    ];

    lsps = [
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      shellcheck
      nodePackages.bash-language-server
      marksman
      nodePackages.pyright
      taplo
      nodePackages.vim-language-server
      lua-language-server
    ];

    nix = [
      nil
      alejandra
    ];

    pythonToolchain = [
      (python39.withPackages (ps:
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
      # unstable.opam # maybe I'll need this
      mypkgs.logisim-evolution
      rars
    ]
    ++ haskellToolchain
    ++ utils
    ++ lsps
    ++ nix
    ++ pythonToolchain;
}
