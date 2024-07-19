function tmux_last \
    --description "Toggle the last tmux session"

    set tmux_last /tmp/TMUX_LAST
    if [ ! -f $tmux_last ]
        echo "Last session is not yet set"
        exit 1
    end

    set session_name (cat $tmux_last)

    __tmux_register_session
    __tmux_maybe_create $session_name $session_name
    __tmux_attach_or_switch $session_name

end
