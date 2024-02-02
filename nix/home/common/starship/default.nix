{...}: {
  programs.starship = let
    inherit (builtins) readFile;
  in {
    enable = true;
    enableFishIntegration = true;
    settings = fromTOML (readFile ./starship.toml);
  };
}
