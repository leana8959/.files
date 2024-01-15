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

    # Generic LSPs
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    nodePackages.bash-language-server # Bash
    marksman # Markdown
    nodePackages.pyright # Python
    taplo # TOML
    texlab # LaTeX
    typescript # TypeScript
    nodePackages.vim-language-server # Vim Script
    lua-language-server # Lua

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
  ];
}
