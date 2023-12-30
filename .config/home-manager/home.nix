{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  inherit (pkgs.lib) optionals;

  unstable =
    import
    (fetchTarball "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz")
    {};
in {
  home.username = "leana";
  home.homeDirectory =
    if isDarwin
    then "/Users/leana"
    else "/home/leana";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.overlays = [
    (final: prev: {
      cmus = prev.cmus.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (prev.fetchpatch {
              url = "https://github.com/cmus/cmus/commit/4123b54bad3d8874205aad7f1885191c8e93343c.patch";
              hash = "sha256-YKqroibgMZFxWQnbmLIHSHR5sMJduyEv6swnKZQ33Fg=";
            })
          ];
      });
    })
  ];

  home.packages = with pkgs; ([
      # text/editors
      helix
      gnused
      neovim
      ripgrep
      vim
      tmux

      # nix
      nil
      alejandra

      # shell
      fish
      (python39.withPackages (ps: with ps; [beautifulsoup4 requests]))
      stow

      fd
      fzf
      htop
      starship
      tree
      vivid
      rsync

      # fancy utilities
      figlet
      macchina
      ncdu
      tldr

      # git related
      bat
      delta
      gnupg
      git
      git-lfs
    ]
    ++ optionals isDarwin [
      (nerdfonts.override {
        fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];
      })

      asciinema
      cmus
      cmusfm
      hyperfine
      tea
      yt-dlp
      watchexec

      jdk17
      rustup
      nodejs_20

      # # NOTE: should be fixed soon
      # unstable.opam

      unstable.typst
    ]
    ++ optionals isLinux [
      # # NOTE: doesn't work
      # valgrind
      gdb
    ]);

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
