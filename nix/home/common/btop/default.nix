{...}: {
  programs.btop.enable = true;

  home.file = {
    btop = {
      source = ../../../../.config/btop;
      target = ".config/btop";
    };
  };
}
