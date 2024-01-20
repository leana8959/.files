{
  pkgs,
  mypkgs,
  ...
}: {
  home.packages = with pkgs; [
    # utils
    hyperfine
    watchexec
    tea
    tokei
    gnumake

    # use-everywhere LSPs
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    shellcheck
    nodePackages.bash-language-server
    marksman
    nodePackages.pyright
    taplo
    nodePackages.vim-language-server
    lua-language-server

    # nix related
    nil
    alejandra

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

    # unstable.opam # maybe I'll need this

    mypkgs.logisim-evolution
    rars
  ];
}
