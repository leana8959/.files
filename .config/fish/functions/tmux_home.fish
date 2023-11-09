function tmux_home

    set session_name "home"

    # create session if doesn't exist
    if ! tmux has-session -t=$session_name 2> /dev/null
        tmux \
            new-session -ds $session_name \; \
            new-window -t $session_name \; \
            select-window -t $session_name:1
    end

    # attach or switch
    if [ -z $TMUX ]
        tmux attach-session -t $session_name
    else
        tmux switch-client -t $session_name
    end

end
