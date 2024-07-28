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
    lidSwitch = "hibernate";
    lidSwitchExternalPower = "ignore";
  };
}
