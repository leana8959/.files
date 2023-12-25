{pkgs, ...}: {
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix

    ./bootloader.nix
    ./locale.nix
    ./networking.nix
    ./packages.nix
    ./sound.nix
    ./users.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
