# idea stolen from the one and only primeagen
# aiming to create one session per directory

function tmux-sessionizer
    set -f session (string escape -- $PWD)

    tmux start-server

    if not tmux has-session -t $session > /dev/null 2>&1
        tmux new-session -d -s $session 'nvim'
        tmux new-window -t $session:1 'fish'
    end

    tmux select-window -t $session:0
    tmux attach-session -t $session
end
