# idea stolen from the one and only primeagen
# aiming to create one session per directory

function tmux-vim
    set -f session (snakecase $PWD)

    tmux start-server

    if not tmux has-session -t $session > /dev/null 2>&1
        tmux new-session -d -s $session -n 'nvim' "nvim $argv"
    end

    tmux attach-session -t $session
end
