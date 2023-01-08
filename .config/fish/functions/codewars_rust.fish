function codewars_rust

    if count $argv >/dev/null
        mkdir ~/repos/codewars/Rust/"$argv"
        mkdir ~/repos/codewars/Rust/"$argv"/src
        touch ~/repos/codewars/Rust/"$argv"/src/main.rs
        echo >~/repos/codewars/Rust/"$argv"/Cargo.toml "\
[package]
name = \"$argv\"
version = \"1.0.0\"
authors = [ \"Léana 江 <leana.jiang@icloud.com>\" ]

[dependencies]

[[bin]]
name = \"main\"\
"
        codium ~/repos/codewars/Rust/"$argv"
    else
        echo "You must provide a new project name"
        return 1
    end

end
