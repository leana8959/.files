# Inspired by the one and only primeagen

# This script names each session with the name of the directory where tmux is invoked
# If there's already a session present for that directory, fuzzy search your way through

function tmux-vim --description 'NeoVim, but in tmux (better)'

    tmux start-server

    if not tmux has-session -t "$PWD" > /dev/null 2>&1
        # create new session and attach to it
        tmux new-session -s "$PWD" -n "nvim" "nvim $argv"
        commandline --function repaint
        return $status
    else
        # attach to existing session(s)
        set -f choice (string join ';' "new" (tmux list-sessions -F "#{session_name}") | tr ';' '\n' | fzf)
    end

    if test -z $choice
        echo "[empty choice]"
    else if test $choice = "new"
        read -l -P "How would you like to name this session? " custom_name
        tmux new-session -s "$custom_name"@"$PWD" -n 'nvim' "nvim $argv"
        commandline --function repaint
        return $status
    else
        tmux attach-session -t "$choice"
        commandline --function repaint
        return $status
    end


end
