{pkgs, ...}: {
  services.xserver = {
    enable = true;
    autoRepeatDelay = 300;
    autoRepeatInterval = 40;

    displayManager.gdm.enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: with hp; [neat-interpolation];
    };
  };
  programs.nm-applet.enable = true;

  programs.gnome-terminal.enable = true;
}
