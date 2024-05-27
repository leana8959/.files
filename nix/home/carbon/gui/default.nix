{ pkgs, ... }:
let
  inherit (pkgs) myPkgs wired;
in
{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 32;
  };

  home.packages = [
    # fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "JetBrainsMono"
        "Meslo"
      ];
    })
    pkgs.lmodern
    pkgs.noto-fonts
    pkgs.noto-fonts-lgc-plus
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-emoji-blob-bin
    pkgs.hanazono
    pkgs.cascadia-code
    myPkgs.hiosevka-nerd-font-mono
    myPkgs.hiosevka

    # Window Manager related
    pkgs.dmenu
    pkgs.xmobar
    pkgs.scrot
    pkgs.xclip
    pkgs.feh
    pkgs.xscreensaver # TODO: why the service option won't work ?
    wired
    pkgs.playerctl

    # GUI apps
    # social
    pkgs.discord
    pkgs.element-desktop
    pkgs.mattermost-desktop

    # productivity
    pkgs.bitwarden
    pkgs.sioyek
    pkgs.evince
    pkgs.gnome.eog
    pkgs.gnome.nautilus
    pkgs.gnome.sushi
    pkgs.evolution
    pkgs.gnome.gnome-calendar
    pkgs.p7zip
  ];

  programs.kitty.enable = true;

  home.file = {
    xmonad = {
      recursive = true;
      source = ./xmonad;
      target = ".config/xmonad";
    };
    xmobar = {
      recursive = true;
      source = ./xmobar;
      target = ".config/xmobar";
    };
    wired = {
      recursive = true;
      source = ./wired;
      target = ".config/wired";
    };
    xscreensaver = {
      source = ./xscreensaver/.xscreensaver;
      target = ".xscreensaver";
    };
  };
}
