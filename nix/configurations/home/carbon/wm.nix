{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "volantes_cursors";
    package = pkgs.volantes-cursors;
    size = 48;
  };

  home.packages = [
    # Fonts
    pkgs.noto-fonts
    pkgs.noto-fonts-lgc-plus
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-emoji-blob-bin
    myPkgs.hiosevka-nerd-font-mono
    myPkgs.hiosevka

    pkgs.xmobar
    pkgs.jetbrains-mono # for xmobar
    pkgs.dmenu
    pkgs.xclip
    pkgs.feh
    pkgs.xscreensaver # TODO: why the service option won't work ?
    pkgs.wired
    pkgs.playerctl
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
    myPkgs.xbrightness
  ];
}
