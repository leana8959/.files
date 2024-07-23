{ pkgs, ... }:

let
  inherit (pkgs) myPkgs wired;
in

{
  imports = [ ./browser.nix ];

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 32;
  };

  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.gnutar

    # Fonts
    pkgs.noto-fonts
    pkgs.noto-fonts-lgc-plus
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-emoji-blob-bin
    pkgs.hanazono
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
    pkgs.jetbrains-mono # for xmobar
    (
      let
        inherit (pkgs.haskellPackages) ghcWithPackages;
        haskellPackages = self: [
          self.xmonad-contrib
          self.xmonad-extras
          self.neat-interpolation
        ];
      in
      ghcWithPackages haskellPackages
    )
    pkgs.haskell-language-server

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

  home.file.xscreensaver = {
    source = ./xscreensaver/.xscreensaver;
    target = ".xscreensaver";
  };
}
