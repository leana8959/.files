{ pkgs, wired, ... }: {

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 32;
  };

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
    xclip
    wired.wired

    # GUI apps

    # social
    discord
    element-desktop

    # productivity
    bitwarden
    sioyek
    thunderbird
  ];

  services.xscreensaver = {
    enable = true;
    settings = {
      fade = false;
      unfade = false;
      timeout = "0:10:00";
      lock = true;
      mode = "unknownpleasures";
    };
  };

  programs.gnome-terminal = {
    enable = true;
    themeVariant = "light";
    # showMenubar = false;
    showMenubar = true;
    profile."060efe23-3ab4-4c71-8a38-dd13f89b400d" = {
      default = true;
      visibleName = "Atom OneLight";
      audibleBell = false;
      font = "CaskaydiaCove Nerd Font Mono 15";
      colors = {
        # NOTE: there's no "black on white to be chosen"
        foregroundColor = "#000000";
        backgroundColor = "#FFFFFF";
        palette = [
          "#000000" "#000000"
          "#E75644" "#E75545"
          "#4DA24B" "#4DA24B"
          "#DBC28F" "#DBC28F"
          "#3E74F5" "#3E74F5"
          "#A925A5" "#B128A6"
          "#4DA24B" "#4DA24B"
          "#C7C7C7" "#FFFFFF"
          ];
      };
    };
  };

}
