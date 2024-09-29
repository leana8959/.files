{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.services.typst-bot;
  t = lib.types;
in

{

  options = {

    services.typst-bot = {

      enable = lib.mkEnableOption "typst-bot";

      dataDir = lib.mkOption {
        description = "Cache directory";
        type = t.path;
        default = "/var/typst-bot";
      };

      environmentFile = lib.mkOption {
        description = "Path to an environment file, you can set the token there";
        type = t.path;
      };

    };

  };

  config = lib.mkIf cfg.enable {

    users.users."typst-bot" = {
      group = "typst-bot";
      isSystemUser = true;
    };
    users.groups."typst-bot" = { };

    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir}/cache  700 typst-bot typst-bot - -"
      "d ${cfg.dataDir}/sqlite 700 typst-bot typst-bot - -"
    ];

    systemd.services."typst-bot" = {
      description = "A discord bot to render Typst code";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        touch ${cfg.dataDir}/sqlite/db.sqlite
      '';

      # Don't pollute the global path
      path = [ pkgs.myPkgs.typst-bot ];
      script = "typst-bot";

      serviceConfig = {
        User = "typst-bot";
        Group = "typst-bot";

        EnvironmentFile = [
          "${pkgs.writeText "typst-bot-env" ''
            DB_PATH=${cfg.dataDir}/sqlite/db.sqlite
            CACHE_DIRECTORY=${cfg.dataDir}/cache
          ''}"
          cfg.environmentFile
        ];
      };

    };

  };

}
