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

  imports = [./services];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      allow-import-from-derivation = true
      keep-outputs = true
      keep-derivations = true
    '';
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
