defaultHost := "carbon"
defaultLink := "/nix/var/nix/profiles/system"

update:
        # package sets
        nix flake update nixpkgs
        nix flake update home-manager
        nix flake update nur

build host=defaultHost:
        nix build ".#nixosConfigurations.{{ host }}.config.system.build.toplevel" --log-format internal-json --verbose |& nom --json

diffLink link=defaultLink host=defaultHost:
        nvd diff {{link}} result

updateBuildDiffLink: update build diffLink
