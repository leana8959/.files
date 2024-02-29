{
  pkgs,
  hostname,
  ...
} @ input: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 4;
  services.nix-daemon.enable = true;

  networking.hostName = hostname;
  environment.shells = [pkgs.fish];

  imports = [./services.nix];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      allow-import-from-derivation = true
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 60d";
    };
    settings.auto-optimise-store = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    gnumake
    gnused
    gcc

    input.llama-cpp
  ];
}
