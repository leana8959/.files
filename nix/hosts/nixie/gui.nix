{ ... }: {
  services.xserver.enable = true;

  services.xserver = {
    autoRepeatDelay = 300;
    autoRepeatInterval = 40;
  };

  services.xserver = {
    displayManager.gdm.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: with hp; [ neat-interpolation ];
    };
  };

  services.xserver.libinput = {
    mouse = {
      naturalScrolling = true;
      accelSpeed = "-0.5";
    };
    touchpad = { naturalScrolling = true; };
  };

  programs.light.enable = true;
}
