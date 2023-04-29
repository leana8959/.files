function tmux_attach --description "attach to existing tmux sessions"
    set -f selected (tmux list-sessions -F "#{session_name}" | fzf)

    if test -z $selected
        return 0
    end

    if test -z "$TMUX"
        tmux attach-session -t "$selected"
        return 0
    else
        tmux switch-client -t "$selected"
    end

end
