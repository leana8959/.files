{
  pkgs,
  myPkgs,
  wired,
  ...
}: {
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 32;
  };

  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];})
    lmodern
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    hanazono
    cascadia-code
    myPkgs.hiosevka-nerd-font-mono
    myPkgs.hiosevka

    # Window Manager related
    dmenu
    xmobar
    scrot
    xclip
    feh
    xscreensaver # TODO: why the service option won't work ?
    wired.default
    playerctl

    # GUI apps
    # social
    discord
    element-desktop
    mattermost-desktop

    # productivity
    bitwarden
    sioyek
    evince
    gnome.eog
    gnome.nautilus
    gnome.sushi
    evolution
    gnome.gnome-calendar
    p7zip
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "HiosevkaNFM";
      size = 17;
    };
    settings = {
      foreground = "#000000";
      background = "#ffffff";
      confirm_os_window_close = 0;
      text_composition_strategy = "1.55 0";
      shell = "${pkgs.fish}/bin/fish -c tmux_home";
    };
    extraConfig = ''
      background #f8f8f8
      foreground #2a2b33
      cursor #bbbbbb
      selection_background #ececec
      color0 #000000
      color8 #000000
      color1 #ca1243
      color9 #ca1243
      color2 #50a14f
      color10 #50a14f
      color3 #e5bf6d
      color11 #e5bf6d
      color4 #4078f2
      color12 #4078f2
      color5 #950095
      color13 #a00095
      color6 #0184bc
      color14 #0184bc
      color7 #bbbbbb
      color15 #ffffff
      selection_foreground #f8f8f8
    '';
    shellIntegration.enableFishIntegration = true;
  };

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
