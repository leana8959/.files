{
  pkgs,
  agenix,
  ...
}: {
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
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
