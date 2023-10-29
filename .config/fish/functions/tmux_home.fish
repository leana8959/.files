function tmux_home

    set session_name "home"
    set tmux_running (pgrep tmux)

    if [ -z "$TMUX" ] && [ -z "$tmux_running" ]
        tmux \
            new-session -s $session_name \; \
            new-window -t $session_name \; \
            select-window -t $session_name:1 \;
        return 0
    end

    if ! tmux has-session -t=$session_name 2> /dev/null
        tmux \
            new-session -ds $session_name \; \
            new-window -t $session_name \; \
            select-window -t $session_name:1 \;
    end

    if [ -z $TMUX ]
        tmux attach-session -t $session_name
    else
        tmux switch-client -t $session_name
    end

end
