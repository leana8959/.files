{
  config,
  pkgs,
  lib,
  ...
}:

let
  pass_enabled = config.programs.password-store.enable;

  pass_cfg = {
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
      exts.pass-import
    ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/repos/leana/vault";
    };
  };
  extra_programs = [
    pkgs.pwgen
    pkgs.diceware
  ];
in

{
  home.packages = lib.mkIf pass_enabled extra_programs;
  programs.password-store = lib.mkIf pass_enabled pass_cfg;
}
