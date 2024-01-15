{pkgs, ...}: {
  home.packages = with pkgs; [
    # utils
    hyperfine
    watchexec
    tea
    tokei

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

    (python39.withPackages (ps:
      with ps; [
        beautifulsoup4
        requests
      ]))

    nil
    alejandra
  ];
}
