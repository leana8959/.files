{ pkgs, ... }:

{

  home.packages = [
    pkgs.joshuto

    # preview deps
    pkgs.file
  ];

  xdg.configFile = {
    # NOTE: NO DEFAULT OR INHERITED VALUES FROM A DEFAULT CONFIG

    "joshuto/preview_file.sh" = {
      source = ./preview_file.sh;
      executable = true;
    };

    "joshuto/joshuto.toml".source = ./joshuto.toml;
    "joshuto/keymap.toml".source = ./keymap.toml;
    "joshuto/mimetype.toml".source = ./mimetype.toml;
    "joshuto/theme.toml".source = ./theme.toml;
  };

}
