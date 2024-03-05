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

  nix.settings = {
    trusted-users = ["leana"];
    trusted-substituters = [
      "https://app.cachix.org/cache/leana8959"
      "https://llama-cpp.cachix.org"
    ];
    trusted-public-keys = [
      "leana8959.cachix.org-1:0kiyNv2RiR04ldLZRRm7EC3+4slPi364bX8JKzwpv6A="
      "llama-cpp.cachix.org-1:H75X+w83wUKTIPSO1KWy9ADUrzThyGs8P5tmAbkWhQc="
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    gnumake
    gnused
    gcc
    cachix
  ];
}
