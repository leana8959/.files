{
  programs.starship = {
    enableFishIntegration = true;
    settings = fromTOML (builtins.readFile ./starship.toml);
  };
}
