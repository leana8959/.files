{ lib, ... }:

{
  nix.gc = lib.mkForce {
    # Garbage-collect often
    automatic = true;
    dates = "*:45";

    # Randomize GC to avoid thundering herd effects.
    randomizedDelaySec = "1800";

    options = "--delete-older-than 8d";
  };

  users.users.nix-remote-builder = {
    isNormalUser = true;
    group = "nogroup";

    # credit:
    # https://github.com/nix-community/srvos/blob/main/nixos/roles/nix-remote-builder.nix
    openssh.authorizedKeys.keys = map (key: ''restrict ${key}'') [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEdzs65v65s5sVEv+BClW7qYb0tWuLOZ4e8lIAActeUq root@bismuth"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBt+MINzxBF8uyFIuz/UvMZe9Ml+qxU0hxxi7UAmUzpc leana@bismuth"
    ];
  };

  nix.settings.trusted-users = [ "nix-remote-builder" ];
}
