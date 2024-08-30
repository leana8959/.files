{

  programs.sioyek = {

    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
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
