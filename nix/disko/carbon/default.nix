# Adapted from: https://github.com/nix-community/disko/blob/master/example/luks-lvm.nix

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = throw "Override me or change me";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings = {
                  # # if you want to use the key for interactive login be sure there is no trailing newline
                  # # for example use `echo -n "password" > /tmp/secret.key`
                  # keyFile = "/tmp/secret.key";
                  askPassword = true;
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
          nix = {
            size = "500G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
              mointOptions = [ "noatime" ];
            };
          };
          encrytedSwap = {
            size = "16M";
            content = {
              type = "swap";
              randomEncryption = true;
              priority = 100;
            };
          };
          swap = {
            size = "48G"; # > 32G for hibernation
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
          home = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
