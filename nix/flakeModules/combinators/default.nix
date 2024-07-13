{ withSystem, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib) importApply;
  flakeModules.combinators = importApply ./it.nix { inherit withSystem; };
in

{
  imports = [ flakeModules.combinators ];

  flake = {
    inherit flakeModules;
  };
}
