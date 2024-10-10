{ pkgs, ... }:

{
  users.users."leana".extraGroups = [
    "video" # light
    "i2c" # i2c (for ddcutil)
  ];

  # Control builtin screen brightness
  programs.light.enable = true;

  # Control external screen brightness
  hardware.i2c.enable = true;
  environment.systemPackages = [ pkgs.ddcutil ];

  # Auto setup external screen
  services.autorandr = {
    enable = true;
    hooks.postswitch = {
      "20_xmonad" = "xmonad --restart"; # make sure feh keeps up
    };

    profiles =
      let
        lg-monitor = "00ffffffffffff001e6d0777dd6a0100041f0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a202020012102031c7144900403012309070783010000e305c000e6060501605550023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e";
        built-in = "00ffffffffffff0030e4210500000000001a0104951f1178ea9d35945c558f291e5054000000010101010101010101010101010101012e3680a070381f403020350035ae1000001a542b80a070381f403020350035ae1000001a000000fe004c4720446973706c61790a2020000000fe004c503134305746362d535042370074";

        allOff = {
          eDP-1.enable = false;
          DP-1.enable = false;
          DP-2.enable = false;
          DP-2-1.enable = false;
          DP-2-2.enable = false;
          HDMI-1.enable = false;
          HDMI-2.enable = false;
        };
      in
      {

        "home-DP-2-2" =
          let
            dev = "DP-2-2";
          in
          {
            fingerprint = {
              ${dev} = lg-monitor;
              eDP-1 = built-in;
            };
            config = allOff // {
              ${dev} = {
                enable = true;
                crtc = 1;
                mode = "3840x2160";
                rate = "60";
                primary = true;
              };
            };
            hooks.postswitch = {
              "10_xrdb-dpi" = "xrdb -merge ${pkgs.writeText "xrdb-dpi-config" ''
                Xcursor.size: 84
                Xft.dpi:   163
              ''}";

              "20_alsa" = ''
                amixer set Master 10%
                amixer set Master unmute
              '';
            };
          };

        "laptop" = {
          fingerprint.eDP-1 = built-in;
          config = allOff // {
            eDP-1 = {
              enable = true;
              crtc = 0;
              mode = "1920x1080";
              rate = "60.02";
              primary = true;
            };
          };
          hooks.postswitch = {
            "10_xrdb-dpi" = "xrdb -merge ${pkgs.writeText "xrdb-dpi-config" ''
              Xcursor.size: 64
              Xft.dpi:   120
            ''}";

            "20_alsa" = ''
              amixer set Master 10%
              amixer set Master mute
            '';
          };
        };

      };

  };
}
