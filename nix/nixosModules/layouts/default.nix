{
  services.xserver.xkb = {
    layout = "myDvorak";
    # TODO: figure out how to implement this conditionally
    # options = "caps:swapescape";
    extraLayouts = {
      "myDvorak" = {
        languages = [ "us" ];
        symbolsFile = ./dvorak.xkb;
        description = "Leana's dvorak";
      };
      "myDvorakFrench" = {
        languages = [ "fr" ];
        symbolsFile = ./dvorak-french.xkb;
        description = "Leana's dvorak but baguette";
      };
    };
  };
  console.useXkbConfig = true;
}
