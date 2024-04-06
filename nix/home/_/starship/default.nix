with builtins;
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = fromTOML (readFile ./starship.toml);
  };
}
