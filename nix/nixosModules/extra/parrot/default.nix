{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.services.parrot;
  t = lib.types;
in

{

  options = {

    services.parrot = {

      enable = lib.mkEnableOption "parrot";

      environmentFile = lib.mkOption {
        description = "Path to an environment file, you can set the token there";
        type = t.path;
      };

    };

  };

  config = lib.mkIf cfg.enable {

    users.users."parrot" = {
      group = "parrot";
      isSystemUser = true;
    };
    users.groups."parrot" = { };

    systemd.services."parrot" = {
      description = " A hassle-free, highly performant, self-hosted Discord music bot with YouTube and Spotify support. Powered by yt-dlp.";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "parrot";
        Group = "parrot";

        EnvironmentFile = cfg.environmentFile;

        ExecStart = "${lib.getExe pkgs.parrot}";
      };

    };

  };

}
