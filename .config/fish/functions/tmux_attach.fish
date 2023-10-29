function tmux_attach --description "attach to existing tmux sessions"

    # abandon if tmux not running
    set tmux_running (pgrep tmux)
    if [ -z "$tmux_running" ]
        return 0
    end

    set selected (tmux list-sessions -F "#{session_name}" | fzf)
    if [ -z $selected ]
        return 0
    end

    # attach or switch
    if [ -z "$TMUX" ]
        tmux attach-session -t $selected
    else
        tmux switch-client -t $selected
    end

end
