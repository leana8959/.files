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
  programs.seahorse.enable = true;

  # programs.steam.enable = true;

  virtualisation = {
    docker.enable = true;
    # virtualbox.host.enable = true;
  };
  users.users."leana".extraGroups = [
    "docker"
    # "vboxusers"
  ];
}
