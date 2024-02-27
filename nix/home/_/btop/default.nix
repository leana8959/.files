{
  programs.btop.enable = true;

  # Link manually to get the theme along with the config
  home.file.btop = {
    recursive = true;
    source = ./btop;
    target = ".config/btop";
  };
}
