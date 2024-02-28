{pkgs, ...}: {
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
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
        size = 32;
      };
    };
    xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: with hp; [neat-interpolation];
    };

    xserver.libinput = {
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

  programs.light.enable = true;
}
