{ pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [
      pkgs.fcitx5-chinese-addons
      pkgs.fcitx5-table-extra
    ];
  };

  xdg.configFile."fcitx5".source = ./fcitx;
}
