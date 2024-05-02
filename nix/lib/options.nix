{
  _module.args.defaultOptions =
    { lib, ... }:
    {
      options = {
        cmus.enable = lib.mkOption { default = false; };
        extraUtils.enable = lib.mkOption { default = false; };
        extraLanguageServers.enable = lib.mkOption { default = false; };
        universityTools.enable = lib.mkOption { default = false; };
        git.signCommits = lib.mkOption { default = false; };
      };
    };
}
