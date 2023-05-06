function tmux_attach --description "attach to existing tmux sessions"
    set selected (tmux list-sessions -F "#{session_name}" | fzf)

    if [ -z $selected ]
        return 0
    end

    if [ -z $TMUX ]
        tmux attach-session -t $selected
    else
        tmux switch-client -t $selected
    end

end
