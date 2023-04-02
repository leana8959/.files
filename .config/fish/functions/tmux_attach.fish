function tmux_attach

    if test -z $argv
        set cmd "fish"
    else
        set cmd "$argv"
    end

    set -f choice (tmux list-sessions -F "#{session_name}" | fzf)
    switch $choice
        case ""
            read -l -P "Name your session: " prefix
            if not test -z $prefix
                set prefix $prefix"@"
            end
            tmux new-session -s "$prefix""$PWD" "$cmd"
        case "*"
            tmux attach-session -t "$choice"
    end
    commandline --function repaint
end
