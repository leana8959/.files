function tmux_attach
    # abandon if tmux not running
    set tmux_running (pgrep tmux)
    if [ -z "$tmux_running" ]
        return 0
    end

    set selected (tmux list-sessions -F "#{session_name}" | fzf)
    if [ -z $selected ]
        return 0
    end

    # echo "---attach---" >> /tmp/TMUX_DEBUG
    # echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG
    echo (tmux display-message -p '#S') >/tmp/TMUX_LAST
    # echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG

    if [ -z $TMUX ]
        tmux attach-session -t $selected
    else
        tmux switch-client -t $selected
    end
end
