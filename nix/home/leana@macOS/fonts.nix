{pkgs, ...}: {
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {fonts = ["CascadiaCode" "JetBrainsMono" "Meslo"];})
    lmodern
    cascadia-code
  ];
}
