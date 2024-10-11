function ,
    set ps
    set os
    for p in $argv
        if not string match -q -- "--*" $p
            set -a ps "nixpkgs#$p"
        else
            set -a os "$p"
        end
    end

    set cmd "SHELL=(which fish) IN_NIX_SHELL=\"impure\" nix shell $os $ps"
    echo "Executing `$cmd`..."
    eval $cmd
end
