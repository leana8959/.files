{
  imports = [./substituters.nix];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      allow-import-from-derivation = true
      keep-outputs = true
      keep-derivations = true
      sandbox = true
    '';
    settings.auto-optimise-store = true;
  };
}
