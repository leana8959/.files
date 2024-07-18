{
  flake.nixosModules = {
    # Shared between darwin and nix
    _.imports = [
      ./sudo-conf.nix
      ./system-nixconf.nix
    ];

    layouts = ./layouts;
  };
}
