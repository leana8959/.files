{

  programs.sioyek = {

    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "l";
      "move_right" = "h";
      "screen_down" = [
        "d"
        "<C-d>"
      ];
      "screen_up" = [
        "u"
        "<C-u>"
      ];
    };
    config.should_launch_new_window = "1";

  };

}
