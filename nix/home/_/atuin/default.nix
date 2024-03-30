{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      history_filter = [
        # privacy
        "^echo"
        "-----BEGIN PGP PRIVATE KEY BLOCK-----"
        "^mods"

        # idiot protection
        "^rm -rf"
      ];
      style = "full";
      show_preview = true;
    };
  };
}
