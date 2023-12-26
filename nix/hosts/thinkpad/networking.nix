{
  hostname,
  pkgs,
  ...
}: {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
