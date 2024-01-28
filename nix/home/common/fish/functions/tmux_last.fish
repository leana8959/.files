# create session if doesn't exist
set session_name (cat /tmp/TMUX_LAST)
if ! tmux has-session -t=$session_name 2> /dev/null
    tmux \
        new-session -ds $session_name \; \
        new-window -t $session_name \; \
        select-window -t $session_name:1
end

# echo "---last---" >> /tmp/TMUX_DEBUG
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG
echo (tmux display-message -p '#S') > /tmp/TMUX_LAST
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG

if [ -z $TMUX ]
    tmux attach-session -t $session_name
else
    tmux switch-client -t $session_name
end
