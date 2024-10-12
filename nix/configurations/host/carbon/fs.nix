{
  systemd.tmpfiles.rules = [
    "d /mnt/data    0700 leana leana - -"
    "d /mnt/seagate 0700 leana leana - -"

    "d /home/leana/mnt/tdk32    0700 leana leana - -"

    # tmux_sessionizer directories
    "d /home/leana/repos/      0700 leana leana - -"
    "d /home/leana/univ-repos/ 0700 leana leana - -"
    "d /home/leana/playground/ 0700 leana leana 4w -"
  ];

  fileSystems."/mnt/data" = {
    device = "10.0.0.20:/mnt/mainPool/data";
    fsType = "nfs";
    options = [
      "ro"
      "noauto"
      "user"
    ];
  };

  fileSystems."/home/leana/mnt/tdk32" = {
    device = "/dev/disk/by-uuid/EF28-13EC";
    fsType = "vfat";
    options = [
      "umask=0000"
      "noauto"
      "user"
    ];
  };
}
