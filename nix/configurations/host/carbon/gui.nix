{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 40;

    displayManager.lightdm = {
      enable = true;
      background = "#000000";
      greeters.gtk.cursorTheme = {
        name = "volantes_cursors";
        package = pkgs.volantes-cursors;
        size = 48;
      };
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  services.picom.enable = true;

  services.libinput = {
    mouse = {
      naturalScrolling = true;
      accelSpeed = "-0.5";
    };
    touchpad = {
      naturalScrolling = true;
      tapping = false;
    };
  };
}
