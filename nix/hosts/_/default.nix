{ pkgs, ... }:
{
  imports = [ ./substituters.nix ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      allow-import-from-derivation = true
      sandbox = true
    '';
  };

  nix.registry.flakies = {
    from = {
      id = "flakies";
      type = "indirect";
    };
    to = {
      type = "git";
      url = "https://git.earth2077.fr/leana/flakies";
    };
  };

  security.sudo.extraConfig = ''
    Defaults        lecture = always
    Defaults        lecture_file = ${pkgs.writeText "sudo_lecture_file" ''
      λλλλλλλλλλλλλλλλλλλλλλλλ
            Beep Boop
      Are you sure about this?
          Think twice :3
      λλλλλλλλλλλλλλλλλλλλλλλλ
    ''}
  '';
}
