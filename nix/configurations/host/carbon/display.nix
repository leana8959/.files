{ pkgs, ... }:

{
  users.users."leana".extraGroups = [
    "video"
    "i2c"
  ];

  # Control builtin screen brightness
  programs.light.enable = true;

  # Control external screen brightness
  hardware.i2c.enable = true;
  environment.systemPackages = [ pkgs.ddcutil ];

  # Auto setup external screen
  services.autorandr =
    let
      lg-monitor = "00ffffffffffff001e6d0677dd6a0100041f0103803c2278ea3e31ae5047ac270c50542108007140818081c0a9c0d1c081000101010108e80030f2705a80b0588a0058542100001e04740030f2705a80b0588a0058542100001a000000fd00383d1e873c000a202020202020000000fc004c472048445220344b0a202020019302033b714d9022201f1203040161605d5e5f230907076d030c001000b83c20006001020367d85dc401788003e30f0003e305c000e6060501605550023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a000000ff003130344e544b4632513839330a0000000000000000000000000000dd";
      built-in = "00ffffffffffff0030e4210500000000001a0104951f1178ea9d35945c558f291e5054000000010101010101010101010101010101012e3680a070381f403020350035ae1000001a542b80a070381f403020350035ae1000001a000000fe004c4720446973706c61790a2020000000fe004c503134305746362d535042370074";

      allOff = {
        eDP-1.enable = false;
        DP-1.enable = false;
        DP-2.enable = false;
        HDMI-1.enable = false;
        HDMI-2.enable = false;
      };
    in
    {
      enable = true;
      profiles."home" = {
        fingerprint.HDMI-2 = lg-monitor;
        fingerprint.eDP-1 = built-in;
        config = allOff // {
          HDMI-2 = {
            enable = true;
            crtc = 1;
            mode = "2560x1440";
            rate = "59.95";
            primary = true;
          };
        };
      };
      profiles."laptop" = {
        fingerprint.eDP-1 = built-in;
        config = allOff // {
          eDP-1 = {
            crtc = 0;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.02";
          };
        };
      };
    };
}
