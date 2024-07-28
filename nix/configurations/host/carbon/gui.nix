{ pkgs, ... }:

let
  inherit (pkgs) myPkgs;
in

{
  services = {
    xserver.enable = true;

    xserver = {
      autoRepeatDelay = 300;
      autoRepeatInterval = 40;
    };

    picom.enable = true;
    xserver.displayManager.lightdm = {
      enable = true;
      background = "#000000";
      greeters.gtk.cursorTheme = {
        name = "Posy_Cursor_Black";
        package = myPkgs.posy-cursor;
        size = 48;
      };
    };
    xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [ hp.neat-interpolation ];
    };

    libinput = {
      mouse = {
        naturalScrolling = true;
        accelSpeed = "-0.5";
      };
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };
  };

  hardware.i2c.enable = true;
  users.users."leana".extraGroups = [ "i2c" ];
  environment.systemPackages = [ pkgs.ddcutil ];

  programs.light.enable = true;
}
