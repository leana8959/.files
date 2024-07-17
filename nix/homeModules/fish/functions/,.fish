function ,
set ps
for p in $argv
    set -a ps "nixpkgs#$p"
end

set cmd "nix shell $ps"
echo "Executing `$cmd`..."
eval $cmd
end
