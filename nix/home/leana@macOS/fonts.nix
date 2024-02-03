{pkgs, ...}: {
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {
      fonts = [
        "CascadiaCode"
        "JetBrainsMono"
        "Meslo"
        "IosevkaTerm"
        "Iosevka"
      ];
    })
    lmodern
    cascadia-code
  ];
}
