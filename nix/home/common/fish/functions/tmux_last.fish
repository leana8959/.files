# create session if doesn't exist
set session_name $TMUX_LAST
if ! tmux has-session -t=$session_name 2> /dev/null
    tmux \
        new-session -ds $session_name \; \
        new-window -t $session_name \; \
        select-window -t $session_name:1
end

set -U TMUX_LAST (tmux display-message -p '#S')
if [ -z $TMUX ]
    tmux attach-session -t $session_name
else
    tmux switch-client -t $session_name
end
