{
  # mount follows the permission of the mount points
  systemd.tmpfiles.rules = [
    "d /mnt/data 0700 leana leana - -"
    "d /mnt/pny-backup 0700 leana leana - -"
  ];

  fileSystems = {
    "/mnt/data" = {
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

    # PNY CS900 SSD
    "/mnt/pny-backup" = {
      device = "/dev/disk/by-uuid/4d1bc604-5cf6-45ce-8c02-59128a95f3cd";
      fsType = "ext4";
      options = [
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=10min"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
      ];
    };
  };
}
