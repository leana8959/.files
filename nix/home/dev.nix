{pkgs, ...}: {
  home.packages = with pkgs; [
    # editors and utils
    tmux
    neovim
    vim
    hyperfine
    watchexec
    tea

    # git
    git
    git-lfs
    bat
    delta
    gnupg

    nil
    alejandra

    (python39.withPackages (ps: with ps; [beautifulsoup4 requests]))
    jdk17
    rustup
    nodejs_20
  ];
}
