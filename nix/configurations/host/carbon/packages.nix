{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.curl
    pkgs.stow
    pkgs.gcc

    pkgs.agenix
  ];

  programs.vim.defaultEditor = true;
  programs.git.enable = true;
  # TODO: moved to home-manager, verify this
  # programs.gnupg.agent = {
  #   enable = true;
  #   pinentryPackage = pkgs.pinentry-curses;
  #   settings = {
  #     default-cache-ttl = 1209600;
  #     max-cache-ttl = 1209600;
  #   };
  # };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
