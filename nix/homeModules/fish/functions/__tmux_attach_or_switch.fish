function __tmux_attach_or_switch \
    --description "Attach (not in tmux) or switch (in tmux) to a session"
    ### Arguments:
    set session_name $argv[1]

    if [ -z "$TMUX" ]
        tmux attach-session -t $session_name
    else
        tmux switch-client -t $session_name
    end

end
