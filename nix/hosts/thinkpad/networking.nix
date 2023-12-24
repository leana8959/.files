{hostname, ...}: {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
}
