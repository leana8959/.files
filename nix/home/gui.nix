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
    feh
    xscreensaver # TODO: why the service option won't work ?
    wired.wired
    playerctl

    # GUI apps
    # social
    discord
    element-desktop

    # productivity
    bitwarden
    sioyek
    thunderbird
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 15;
    };
    settings = {
      foreground = "#000000";
      background = "#ffffff";
      confirm_os_window_close = 0;
      text_composition_strategy = "1.55 0";
    };
    shellIntegration.enableFishIntegration = true;
  };

}
