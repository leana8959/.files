{
  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      history_filter = [
        "^ *echo" # sometimes I pipe secrets to files
        "-----BEGIN PGP PRIVATE KEY BLOCK-----"
      ];
      style = "full";
      show_preview = true;
    };
  };
}
