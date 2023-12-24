{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    vim
    stow
    git
    gcc
  ];

  # TODO: try to move this to home-manager
  programs = {
    gnome-terminal.enable = true;
  };

  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp:
        with hp; [
          neat-interpolation
        ];
    };
    displayManager.gdm.enable = true;
  };
  programs.nm-applet.enable = true;

  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
}
