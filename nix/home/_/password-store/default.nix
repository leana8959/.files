{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = {
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp
      exts.pass-import
    ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/repos/leana/vault";
    };
  };
in

{
  programs.password-store = lib.mkIf config.programs.password-store.enable cfg;
}
