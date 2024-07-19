function tmux_home \
    --description "Take me back to ~"

    set session_name home

    if [ -n "$TMUX" ]
        __tmux_register_session
    end

    if pgrep tmux 2>&1 >/dev/null; or ! tmux has -t=$session_name 2>/dev/null
        tmux \
            new-session -ds home \; \
            new-window -t home \; \
            select-window -t "home":1
    end

    __tmux_attach_or_switch $session_name

end
