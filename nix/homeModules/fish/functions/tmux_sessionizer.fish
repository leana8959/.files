function tmux_sessionizer
# Inspired by the one and only primeagen
set selected \
    (begin
        # use fd even though it's an extra dependency because find is too slow
        fd . $REPOS_PATH $UNIV_REPOS_PATH --exact-depth 2 --type d;
        fd . $PLAYGROUND_PATH --exact-depth 1 --type d;
        echo "play"
    end 2> /dev/null | sed -e "s|^$HOME|~|" | fzf)

set selected (echo $selected | sed -e "s|^~|$HOME|")

if [ -z $selected ]
    commandline --function repaint
    return 0
end

switch $selected
case "play"
    read -P "Give it a name: " name
    if test -z $name
        return 0
    else
        set name (snakecase $name)
        set selected ~/playground/$name/
        mkdir -p $selected
    end
end

set session_name (echo $selected | tr . _)
# echo "---sess---" >> /tmp/TMUX_DEBUG
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG
echo (tmux display-message -p '#S') > /tmp/TMUX_LAST
# echo (cat /tmp/TMUX_LAST) >> /tmp/TMUX_DEBUG

# create session if doesn't exist
if ! tmux has -t=$session_name 2> /dev/null
    tmux \
        new-session -ds $session_name -c $selected \; \
        send-keys -t $session_name $EDITOR ENTER \; \
        new-window -t $session_name -c $selected \; \
        select-window -t $session_name:1 \;
end

if [ -z $TMUX ]
    tmux attach-session -t $session_name
else
    tmux switch-client -t $session_name
end
end
