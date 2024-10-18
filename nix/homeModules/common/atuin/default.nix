{
  programs.atuin = {
    flags = [ "--disable-up-arrow" ];
    settings = {
      history_filter = [
        # privacy
        "^echo"
        ".*PASSWORD=.*"
        ".*TOKEN=.*"

        # idiot protection
        ".*rm -rf.*"
      ];
      style = "full";
      show_preview = true;
    };
  };
}
