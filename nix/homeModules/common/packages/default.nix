{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (pkgs) myPkgs;
in

{
  options.extraPackages = {
    utilities.enable = lib.mkEnableOption "utility packages";
    workflow.enable = lib.mkEnableOption "worflow packages";
  };

  config = {
    programs.home-manager.enable = true;
    home = {
      username = lib.mkDefault "leana";
      homeDirectory = lib.mkMerge [
        (lib.mkIf pkgs.stdenv.isLinux (lib.mkDefault "/home/leana"))
        (lib.mkIf pkgs.stdenv.isDarwin (lib.mkDefault "/Users/leana"))
      ];
    };

    programs.ripgrep.enable = true;
    home.packages = lib.mkMerge [
      [
        # shell and script dependencies
        pkgs.figlet
        pkgs.gnused
        pkgs.stow
        pkgs.fd
        pkgs.vivid

        # nix
        pkgs.nixfmt-rfc-style

        # utils
        pkgs.tree
        pkgs.tldr
        pkgs.parallel
        pkgs.findutils # xargs and more
        pkgs.du-dust
        pkgs.file
      ]

      (lib.mkIf pkgs.stdenv.isDarwin [
        # coreutils for darwin
        pkgs.uutils-coreutils-noprefix
      ])

      (lib.mkIf config.extraPackages.utilities.enable [
        pkgs.rsync
        pkgs.jq
        pkgs.hyperfine
        pkgs.watchexec
        pkgs.onefetch
        pkgs.ghostscript
        myPkgs.tokei
        pkgs.gnumake
        pkgs.just
        pkgs.nurl
        pkgs.tea
        pkgs.agenix
        pkgs.nvd
        pkgs.nix-tree
      ])

      (lib.mkIf config.extraPackages.workflow.enable [
        pkgs.act
        pkgs.forgejo-actions-runner
      ])
    ];
  };
}
