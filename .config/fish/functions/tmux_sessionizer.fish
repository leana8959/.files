# Inspired by the one and only primeagen

function tmux_sessionizer --description "create tmux sessions"
    set selected \
        (begin
            fd . $REPOS_PATH $UNIV_REPOS_PATH --exact-depth 2 --type d;
            fd . $PLAYGROUND_PATH --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Rust --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Haskell --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/C --exact-depth 1 --type d;
            fd . $ZEROJUDGE_PATH --exact-depth 1 --type d;
            echo "play";
            echo "codewars rust";
            echo "codewars haskell";
            echo "codewars c";
            echo "zerojudge c";
        end | fzf)

    switch $selected
    case ''
        return 0

    case "play"
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected ~/playground/$name/
            mkdir -p $selected
        end

    case "codewars rust"
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set kata_name (snakecase $name)
            set selected $CODEWARS_PATH/Rust/$kata_name/
            cargo new $selected --name codewars_$kata_name --vcs none
        end

    case "codewars haskell"
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/Haskell/$name/
            mkdir -p $selected
            touch $selected/main.hs
        end

    case "codewars c"
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/C/$name/
            mkdir -p $selected
            touch $selected/main.c
        end

    case "zerojudge c"
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set selected $ZEROJUDGE_PATH/$name/
            mkdir -p $selected
            touch $selected/main.c
        end
    end

    set selected_name (echo $selected | tr . _)
    set tmux_running (pgrep tmux)

    if [ -z "$TMUX" ] && [ -z "$tmux_running" ]
        tmux \
            new-session -s $selected_name -c $selected \; \
            send-keys -t $selected_name nvim ENTER \; \
            new-window -t $selected_name -c $selected \; \
            select-window -t $selected_name:1 \;
        return 0
    end

    if ! tmux has-session -t=$selected_name 2> /dev/null
        tmux \
            new-session -ds $selected_name -c $selected \; \
            send-keys -t $selected_name nvim ENTER \; \
            new-window -t $selected_name -c $selected \; \
            select-window -t $selected_name:1 \;
    end

    if [ -z $TMUX ]
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    end

end
