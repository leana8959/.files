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
  options.extra = {
    utilities.enable = lib.mkEnableOption "utility packages";
    workflow.enable = lib.mkEnableOption "worflow packages";
    university.enable = lib.mkEnableOption "university related packages";
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
      ]

      (lib.mkIf pkgs.stdenv.isDarwin [
        # coreutils for darwin
        pkgs.uutils-coreutils-noprefix
      ])

      (lib.mkIf config.extra.utilities.enable [
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
      ])

      (lib.mkIf config.extra.workflow.enable [
        pkgs.act
        pkgs.forgejo-actions-runner
      ])

      (lib.mkIf config.extra.university.enable [
        pkgs.rars
        myPkgs.logisim-evolution
        myPkgs.necrolib
        myPkgs.why3

        pkgs.isabelle
        pkgs.hol
      ])
    ];
  };
}
