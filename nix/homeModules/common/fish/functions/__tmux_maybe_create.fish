function __tmux_maybe_create \
    --description "Create a tmux session with sensible defaults if it doesn't exist yet"
    ### Arguments:
    set session_name $argv[1]
    set session_dir $argv[2]

    if pgrep tmux 2>&1 >/dev/null; or ! tmux has -t=$session_name 2>/dev/null
        tmux \
            new-session -ds $session_name -c $session_dir \; \
            send-keys -t $session_name $EDITOR ENTER \; \
            new-window -t $session_name -c $session_dir \; \
            select-window -t $session_name:1
    end

end
