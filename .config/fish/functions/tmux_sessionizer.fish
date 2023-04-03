# Inspired by the one and only primeagen

# Name each session with the name of the directory where tmux is invoked
# If there's already a session present for that directory, fuzzy search your way through
function tmux_sessionizer --description 'manage tmux sessions'
    tmux start-server

    if test -z $argv[1]
        set cmd "fish"
    else
        set cmd "$argv"
    end

    if not tmux list-sessions -F '#{session_name}' | rg "^$PWD\$" > /dev/null
        # create new session and attach to it
        tmux new-session -s "$PWD" "$cmd"
    else
        # attach to existing session(s)
        tmux_attach $argv
    end
end
