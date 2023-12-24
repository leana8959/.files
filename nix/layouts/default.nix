{...}: {
  services.xserver.xkb = {
    layout = "dvorak";
    extraLayouts = {
      "dvorak" = {
        languages = ["us"];
        symbolsFile = ./dvorak.xkb;
        description = "Leana's dvorak";
      };
      "dvorak-french" = {
        languages = ["fr"];
        symbolsFile = ./dvorak-french.xkb;
        description = "Leana's dvorak but baguette";
      };
    };
  };
  console.useXkbConfig = true;
}
