function tmux_attach --description "attach to existing tmux sessions"
    set -f selected (tmux list-sessions -F "#{session_name}" | fzf)

    if test -z "$TMUX"
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    end

end
