{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;

  wallpapers = {
    nixos = pkgs.fetchurl {
      url = "https://c.wallhere.com/photos/49/ce/Linux_Nixos_operating_system_minimalism-2175179.jpg!d";
      hash = "sha256-RdrkvsVB6fHnyDZQ6wCGc7lUP7FoDYGvx2jfWB1WSvI=";
    };

    sequoia = pkgs.fetchurl {
      url = "https://basicappleguy.com/s/SequoiaLight.png";
      hash = "sha256-F3vo07kdE19luHtrBO8Q+Rj0mk+UlgtOSwOVdFW8Vlk=";
    };

    apple-pride-mac = pkgs.fetchurl {
      url = "https://basicappleguy.com/s/Pride_Mac2.png";
      hash = "sha256-PkGIlWf554Lk5e2gLDpDg+Rmb9qAniTiNvbV3/pppwA=";
    };

    apple-nebula-ipad = pkgs.fetchurl {
      url = "https://basicappleguy.com/s/NebulaiPad.png";
      hash = "sha256-rpWxhCH7eIT7ktRAROvL56eRK0T6AsgGE+iI/CLUF3k=";
    };

    "luz&amity_20_windz" = pkgs.fetchurl {
      url = "https://64.media.tumblr.com/a28bd2446401e30cc879a641a3038ac7/fcdeee73cdb01c35-18/s2048x3072/c6c89f6de58d26eeb9848d5f41b20ebbcec94b6d.pnj";
      hash = "sha256-isdyegUoGXZyFDCyBMCNadIv/jry82slXkjcdXpNKrY=";
    };
  };

in

{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "volantes_cursors";
    package = pkgs.volantes-cursors;
    size = 64;
  };

  home.file = {
    ".xscreensaver".source = ./xscreensaver/.xscreensaver;
    ".wallpaper".source = wallpapers."luz&amity_20_windz";
  };

  home.packages = [
    # Fonts
    pkgs.noto-fonts
    pkgs.noto-fonts-lgc-plus
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-emoji-blob-bin
    myPkgs.altiosevka-nerd-font-mono
    myPkgs.altiosevka

    pkgs.xmobar
    pkgs.wired
    pkgs.jetbrains-mono

    pkgs.dmenu
    pkgs.xclip
    pkgs.playerctl

    (pkgs.haskellPackages.ghcWithPackages (self: [
      self.xmonad-contrib
      self.xmonad-extras
      self.neat-interpolation
    ]))

    pkgs.haskell-language-server
    myPkgs.xbrightness
    pkgs.ranger
  ];
}
