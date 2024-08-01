{
  # Note: referencing to self would recurse infinitely.
  imports = [ ./it.nix ];
  flake.flakeModules.combinators = ./it.nix;
}
