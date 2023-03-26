function codewars_rust
    if count $argv >/dev/null
        set -f kata_name "codewars_"(snakecase $argv)
        set -f kata_date (date +%Y.%-m.%-d)
        mkdir -p ~/repos/codewars/Rust/"$argv"
        mkdir -p ~/repos/codewars/Rust/"$argv"/src
        touch ~/repos/codewars/Rust/"$argv"/src/main.rs
        echo >~/repos/codewars/Rust/"$argv"/Cargo.toml "\
[package]
name = \"$kata_name\"
version = \"$kata_date\"
authors = [ \"Léana 江 <leana.jiang@icloud.com>\" ]

[dependencies]
"
        cd ~/repos/codewars/Rust/"$argv"/ && nvim ./src/main.rs && cd
    else
        echo "You must provide a new project name"
        return 1
    end
end
