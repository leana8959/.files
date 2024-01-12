{...}: {
  services = {
    xserver.enable = true;

    xserver = {
      autoRepeatDelay = 300;
      autoRepeatInterval = 40;
    };

    xserver.desktopManager.wallpaper.mode = "fill";

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
