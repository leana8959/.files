{ pkgs, lib, ... }:

{
  systemd.services."set-battery-thres" = {
    enable = true;
    description = "Set the battery charge threshold";
    unitConfig.After = "multi-user.target";
    script = ''
      echo 70 > /sys/class/power_supply/BAT1/charge_control_start_threshold
      echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold
    '';
    serviceConfig.Restart = "on-failure";
    wantedBy = [ "multi-user.target" ];
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "ignore";
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
