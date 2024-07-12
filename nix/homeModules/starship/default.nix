{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = fromTOML (builtins.readFile ./starship.toml);
  };
}
