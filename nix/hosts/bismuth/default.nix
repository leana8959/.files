{pkgs, ...} @ input: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

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
