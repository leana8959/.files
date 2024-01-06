{
  pkgs,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    # Editors and utils
    tmux
    neovim
    vim
    hyperfine
    watchexec
    tea
    tokei
    gnumake

    # Generic LSPs
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    nodePackages.bash-language-server # Bash
    marksman # Markdown
    nodePackages.pyright # Python
    taplo # TOML
    texlab # LaTeX
    typescript # TypeScript
    nodePackages.vim-language-server # Vim Script
    typst-lsp # Typst
    lua-language-server # Lua

    # git
    git
    git-lfs
    bat
    delta
    gnupg

    nil
    alejandra
    nixfmt

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
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
