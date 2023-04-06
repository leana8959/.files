function tmux_attach

    if test -z $argv[1]
        set cmd "fish"
    else
        set cmd "$argv"
    end

    set -f choice (tmux list-sessions -F "#{session_name}" | fzf --query "$PWD ")
    switch $choice
        case ""
            if not read -l -P "Name your session: " name > /dev/null
                echo "[exited]"
                return
            end
            if not test -z $name
                set name @"$name"
            end
            tmux new-session -s "$PWD""$name" "$cmd"
        case "*"
            tmux attach-session -t "$choice"
    end
end
