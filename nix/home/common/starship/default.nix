{...}: {
  programs = let
    inherit (builtins) readFile;
  in {
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = fromTOML (readFile ./starship.toml);
    };
  };
}
