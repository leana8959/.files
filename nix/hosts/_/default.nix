{
  imports = [ ./substituters.nix ];

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

  nix.registry.flakies = {
    from = {
      id = "flakies";
      type = "indirect";
    };
    to = {
      type = "git";
      url = "https://git.earth2077.fr/leana/flakies";
    };
  };
}
