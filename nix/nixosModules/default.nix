{
  flake.nixosModules = {
    _.imports = [
      ./sudo-conf.nix
      ./system-nixconf.nix
    ];

    layouts = ./layouts;
  };
}
