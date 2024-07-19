function __tmux_register_session \
    --description "Register the session, if it's not set yet"
    ### Effects:
    set last /tmp/TMUX_LAST

    set this (tmux display-message -p '#S')
    if [ ! -f "$last" ]; or [ (cat "$last") != "$tmux_current" ]
        echo $this >$last
    end

end
