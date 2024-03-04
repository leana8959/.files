{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = lib.lists.optionals config.docker.enable (
    [
      pkgs.docker
      pkgs.docker-compose
    ]
    ++ lib.lists.optionals pkgs.stdenv.isDarwin [
      pkgs.colima
    ]
  );

  environment.userLaunchAgents = let
    path =
      builtins.concatStringsSep ":"
      (map (p: "${p}/bin") [
        pkgs.docker
        pkgs.docker-compose
      ]);
    defaultPath = "/usr/bin:/bin:/usr/sbin:/sbin";
  in {
    "colima.plist" = {
      # https://github.com/abiosoft/colima/issues/490
      # Doesn't work at the moment
      enable = false;
      # make sure docker and docker-compose is in the path, otherwise `colima` won't launch
      text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
            <dict>
                <key>Label</key> <string>org.nix.colima</string>

                <key>EnvironmentVariables</key>
                <dict>
                    <key>PATH</key>
                    <string>${path}:${defaultPath}</string>
                </dict>

                <key>ProgramArguments</key>
                <array>
                    <string>${pkgs.colima}/bin/colima</string>
                    <string>start</string>
                </array>

                <key>RunAtLoad</key> <true/>

                <key>KeepAlive</key> <true/>

                <key>ThrottleInterval</key> <integer>60</integer>
            </dict>
        </plist>
      '';
    };
  };
}
