{
  pkgs,
  wired,
  ...
}: {
  home.packages = with pkgs; [
    # Window Manager related
    (nerdfonts.override {fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];})
    dmenu
    xmobar
    scrot
    xscreensaver
    trayer
    xclip
    wired.wired

    # GUI apps

    # social
    discord
    element-desktop

    # misc
    bitwarden
    gnome.gnome-terminal
  ];
}
