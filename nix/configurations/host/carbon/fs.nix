{
  systemd.tmpfiles.rules = [
    "d /mnt/data    0700 leana leana - -"
    "d /mnt/seagate 0700 leana leana - -"
  ];

  fileSystems."/mnt/data" = {
    device = "10.0.0.20:/mnt/mainPool/data";
    fsType = "nfs";
    options = [
      "ro"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=30min"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
