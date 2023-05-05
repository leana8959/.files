# Inspired by the one and only primeagen

function tmux_sessionizer --description "create tmux sessions"
    set selected \
        (begin
            find ~/repos ~/univ-repos -mindepth 2 -maxdepth 2 -type d;
            find ~/playground -mindepth 1 -maxdepth 1 -type d;
            echo "play"
        end | fzf)

    if test -z $selected
        return 0
    end

    if [ "$selected" = "play" ]
        read -P "Give it a name: " selected
        if test -z $selected
            return 0
        else
            set selected ~/playground/"$selected"
            mkdir -p $selected
        end
    end

    set selected_name (echo $selected | tr . _)
    set tmux_running (pgrep tmux)

    if [ -z "$TMUX" ] && [ -z "$tmux_running" ]
        tmux \
            new-session -s "$selected_name" -c "$selected" \; \
            new-window -t "$selected_name" -c "$selected" \; \
            select-window -t "$selected_name:1" \;
        return 0
    end

    if ! tmux has-session -t="$selected_name" 2> /dev/null
        tmux \
            new-session -ds "$selected_name" -c "$selected" \; \
            new-window -t "$selected_name" -c "$selected" \; \
            select-window -t "$selected_name:1" \;
    end

    if [ -z "$TMUX" ]
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    end

end
