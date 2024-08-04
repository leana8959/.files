{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      history_filter = [
        # privacy
        "^echo"
        "^-----BEGIN"
        "^mods"
        "^.*PASSWORD=.*"

        # idiot protection
        "^rm -rf"
      ];
      style = "full";
      show_preview = true;
    };
  };
}
