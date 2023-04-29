# Inspired by the one and only primeagen

function tmux_sessionizer --description "create tmux sessions"
    set selected (find ~/repos -mindepth 2 -maxdepth 2 -type d | fzf)

    if test -z $selected
        set selected ~
    end

    set selected_name (echo $selected | tr . _)

    set tmux_running (pgrep tmux)

    if test -z "$TMUX" && test -z "$tmux_running"
        tmux new-session -s "$selected_name" -c "$selected"
    end

    if not tmux has-session -t="$selected_name" 2> /dev/null
        tmux new-session -ds "$selected_name" -c "$selected"
    end

    if test -z "$TMUX"
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    end

end
