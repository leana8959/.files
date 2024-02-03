{
  pkgs,
  mypkgs,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    # Tools
    hyperfine
    watchexec
    tea
    tokei
    gnumake

    # LSPs
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    shellcheck
    nodePackages.bash-language-server
    marksman
    nodePackages.pyright
    taplo
    nodePackages.vim-language-server
    lua-language-server
    fnlfmt

    # nix
    nil
    alejandra

    # University stuff
    unstable.opam
    unstable.cargo
    mypkgs.logisim-evolution
    mypkgs.necrolib
    pkgs.rars
  ];
}
