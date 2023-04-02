# Inspired by the one and only primeagen

# Name each session with the name of the directory where tmux is invoked
# If there's already a session present for that directory, fuzzy search your way through
function tmux_sessionizer --description 'manages tmux sessions'
    tmux start-server

    if test -z $argv
        set -f cmd "fish"
    else
        set -f cmd "$argv"
    end

    if not tmux has-session -t "$PWD" > /dev/null 2>&1
        # create new session and attach to it
        tmux new-session -s "$PWD" "$cmd"
    else
        # attach to existing session(s)
        set -f choice (string join ';' "new" (tmux list-sessions -F "#{session_name}") | tr ';' '\n' | fzf)

        if test -z $choice
            echo "[exited fzf]"
        else if test $choice = "new"
            read -l -P "How would you like to name this session? " custom_name
            tmux new-session -s "$custom_name"@"$PWD" "$cmd"
        else
            tmux attach-session -t "$choice"
        end
    end

    commandline --function repaint
end
