function ,
    set ps
    for p in $argv
        set -a ps "nixpkgs#$p"
    end

    set cmd "SHELL=(which fish) IN_NIX_SHELL=\"impure\" nix shell $ps"
    echo "Executing `$cmd`..."
    eval $cmd
end
