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
      λλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλ

           λλλλ
             λλλ
              λλλ
               λλλ                       Beep Boop
              λ λλλ               Are you sure about this?
             λ   λλλ                  Think twice :3
            λ     λλλ
           λ       λλλ
          λ         λλλ
         λ           λλλλ

      λλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλλ
    ''}
  '';
}
