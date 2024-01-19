# create session if doesn't exist
if ! tmux has-session -t="home" 2> /dev/null
    tmux \
        new-session -ds "home" \; \
        new-window -t "home" \; \
        select-window -t "home":1
end

set -U TMUX_LAST (tmux display-message -p '#S')
if [ -z $TMUX ]
    tmux attach-session -t "home"
else
    tmux switch-client -t "home"
end
