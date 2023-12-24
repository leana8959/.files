{
  pkgs,
  unstable,
  ...
}: {
  users.users.leana = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "leana";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      # Window Manager related
      dmenu
      xmobar
      scrot
      xscreensaver
      trayer
      xclip

      # GUI apps
      # discord
    ];
  };
}
