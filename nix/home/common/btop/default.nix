{...}: {
  programs.btop.enable = true;

  home.file = {
    btop = {
      recursive = true;
      source = ./btop;
      target = ".config/btop";
    };
  };
}
