function tmux_attach

    if test -z $argv
        set cmd "fish"
    else
        set cmd "$argv"
    end

    set -f choice (string join ';' "new" (tmux list-sessions -F "#{session_name}") | tr ';' '\n' | fzf)
    switch $choice
        case ""
        case "new"
            read -l -P "How would you like to name this session? " prefix
            if not test -z $prefix
                set prefix $prefix"@"
            end
            tmux new-session -s "$prefix""$PWD" "$cmd"
        case "*"
            tmux attach-session -t "$choice"
    end
end
