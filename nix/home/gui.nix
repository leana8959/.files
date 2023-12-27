{
  pkgs,
  wired,
  ...
}: {
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];})
    lmodern

    # Window Manager related
    dmenu
    xmobar
    scrot
    xscreensaver
    xclip
    wired.wired

    # GUI apps

    # social
    discord
    element-desktop

    # productivity
    bitwarden
    sioyek

    # util
    gnome.gnome-terminal
  ];

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 32;
  };
}
