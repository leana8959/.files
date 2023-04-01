function codewars_rust
    if count $argv >/dev/null
        set -f kata_name (snakecase $argv)
        set -f kata_date (date +%Y.%-m.%-d)
        mkdir -p ~/repos/codewars/Rust/"$kata_name"
        mkdir -p ~/repos/codewars/Rust/"$kata_name"/src
        touch ~/repos/codewars/Rust/"$kata_name"/src/main.rs
        echo >~/repos/codewars/Rust/"$kata_name"/Cargo.toml "\
[package]
name = \"codewars_$kata_name\"
version = \"$kata_date\"
authors = [ \"Léana 江 <leana.jiang@icloud.com>\" ]

[dependencies]
"
        cd ~/repos/codewars/Rust/"$kata_name"/ && tmux-vim ./src/main.rs && cd
    else
        echo "You must provide a new project name"
        return 1
    end
end
