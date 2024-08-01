{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 40;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
    fadeDelta = 3;
    settings.fade-exclude = [
      "name = 'Fcitx5 Input Window'"
      "class_g = 'fcitx'"
      "class_i = 'fcitx'"
    ];
  };

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
