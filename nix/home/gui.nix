{ pkgs, wired, ... }: {
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "Meslo" ]; })
    lmodern
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    hanazono
    cascadia-code

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
    # TODO: use the programs option to change profiles
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
