{ pkgs, agenix, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    stow
    gcc

    agenix.default
  ];

  programs.vim.defaultEditor = true;
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    settings = {
      default-cache-ttl = 1209600;
      max-cache-ttl = 1209600;
    };
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
