{pkgs, ...}: {
  systemd.services.battery-charge-threshold = {
    enable = true;
    description = "Set the battery charge threshold";
    unitConfig = {
      After = "multi-user.target";
      StartLimitBurst = 0;
    };
    serviceConfig = {
      User = "root";
      Group = "root";
      Type = "oneshot";
      Restart = "on-failure";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 70 > /sys/class/power_supply/BAT1/charge_control_start_threshold; echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold'";
    };
    wantedBy = ["multi-user.target"];
  };
}
