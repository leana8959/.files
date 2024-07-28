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
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
