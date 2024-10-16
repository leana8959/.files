{ pkgs, lib, ... }:

{
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=2hour
  '';
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "ignore";
  };

  services.tlp = {
    enable = true;
    settings = {
      # battery limiter
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 90;
      START_CHARGE_THRESH_BAT1 = 80;
      STOP_CHARGE_THRESH_BAT1 = 90;

      # audio popping fix
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 0;
      SOUND_POWER_SAVE_CONTROLLER = "N";
    };
  };

  systemd.services."battery-notify" = {
    enable = true;
    description = "Scream when battery is dying";
    startAt = [ "*:0/5" ];
    unitConfig.After = "multi-user.target";
    serviceConfig.ExecStart =
      let
        script = pkgs.writeShellApplication {
          name = "battery-notify";
          runtimeInputs = [
            pkgs.bc
            pkgs.libnotify
          ];
          text = ''
            battery="/sys/class/power_supply/BAT1"
            thres="0.2"
            isLow=$(echo "($(cat $battery/energy_now) / $(cat $battery/energy_full)) < $thres" | bc -l)

            if [ "$isLow" -eq 1 ]; then
              echo "You're battery level is below $thres"
              notify-send -u critical "Battery Low" "Please charge your battery"
            fi
          '';
        };
      in
      lib.getExe script;
  };
}
