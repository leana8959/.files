function tmux_home
# echo "---home---" >> /tmp/TMUX_DEBUG
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG
echo (tmux display-message -p '#S') > /tmp/TMUX_LAST
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG

# create session if doesn't exist
if ! tmux has-session -t="home" 2> /dev/null
    tmux \
        new-session -ds "home" \; \
        new-window -t "home" \; \
        select-window -t "home":1
end

if [ -z $TMUX ]
    tmux attach-session -t "home"
else
    tmux switch-client -t "home"
end
end
