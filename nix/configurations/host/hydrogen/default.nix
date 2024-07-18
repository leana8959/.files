{ modulesPath, ... }:

{
  imports = [
    # The generator and hardware configuration
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  networking.wireless.enable = false;
}
