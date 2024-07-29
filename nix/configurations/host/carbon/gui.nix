{ pkgs, ... }:

{
  services = {
    xserver.enable = true;

    xserver = {
      autoRepeatDelay = 300;
      autoRepeatInterval = 40;
    };

    picom.enable = true;
    xserver.displayManager.lightdm = {
      enable = true;
      background = "#000000";
      greeters.gtk.cursorTheme = {
        name = "volantes_cursors";
        package = pkgs.volantes-cursors;
        size = 48;
      };
    };
    xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };

    libinput = {
      mouse = {
        naturalScrolling = true;
        accelSpeed = "-0.5";
      };
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };
  };
}
