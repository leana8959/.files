# Inspired by the one and only primeagen

function tmux_sessionizer --description "create tmux sessions"
    set selected \
        (begin
            find $REPOS_PATH $UNIV_REPOS_PATH -mindepth 2 -maxdepth 2 -type d;
            find $PLAYGROUND_PATH -mindepth 1 -maxdepth 1 -type d;
            find $CODEWARS_PATH/rust -mindepth 1 -maxdepth 1 -type d;
            echo "play";
            echo "codewars_rust";
        end | fzf)

    switch $selected
        case ''
            return 0

        case "play"
            read -P "Give it a name: " selected
            if test -z $selected
                return 0
            else
                set selected ~/playground/"$selected"
                mkdir -p $selected
            end

        case "codewars_rust"
            read -P "Give it a name: " selected
            if test -z $selected
                return 0
            else
                set kata_name (snakecase $selected)
                set selected $CODEWARS_PATH/Rust/$kata_name
                cargo new $selected --name codewars_$kata_name --vcs none
            end
    end

    set selected_name (echo $selected | tr . _)
    set tmux_running (pgrep tmux)

    if [ -z $TMUX ] && [ -z $tmux_running ]
        tmux \
            new-session -s $selected_name -c $selected \; \
            new-window -t $selected_name -c $selected \; \
            select-window -t $selected_name:1 \;
        return 0
    end

    if ! tmux has-session -t=$selected_name 2> /dev/null
        tmux \
            new-session -ds $selected_name -c $selected \; \
            new-window -t $selected_name -c $selected \; \
            select-window -t $selected_name:1 \;
    end

    if [ -z $TMUX ]
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    end

end
