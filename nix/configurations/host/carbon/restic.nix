{ config, ... }:

{
  services.restic.backups."Documents-backblaze" = {
    paths = [ "/home/leana/Documents" ];

    passwordFile = config.age.secrets.restic_backblaze_pwd.path;
    repositoryFile = config.age.secrets.restic_backblaze_repo.path;
    environmentFile = config.age.secrets.restic_backblaze_env.path;

    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 12"
      "--keep-yearly 10"
    ];
  };
}
