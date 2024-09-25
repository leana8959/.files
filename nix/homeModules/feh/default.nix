{

  programs.feh = {
    enable = true;
    keybindings = {
      prev_img = [
        "Left"
        "Up"
      ];
      next_img = [
        "Right"
        "Down"
      ];

      scroll_left = "h";
      scroll_right = "l";
      scroll_up = "k";
      scroll_down = "j";

      # mimic sioyek
      zoom_in = "plus";
      zoom_out = "minus";
      zoom_fit = "=";
    };
  };

}
