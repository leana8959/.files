{ pkgs, ... }:
{
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = [
    pkgs.helvum
    pkgs.pavucontrol
    pkgs.easyeffects
  ];

  users.users."leana".extraGroups = [ "audio" ];
}
