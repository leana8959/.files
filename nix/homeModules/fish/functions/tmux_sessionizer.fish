function tmux_sessionizer \
    --description "Manage tmux sessions in specific folders with fzf"

    set selected \
        (begin
            fd . $REPOS_PATH $UNIV_REPOS_PATH --exact-depth 2 --type d
            fd . $PLAYGROUND_PATH --exact-depth 1 --type d
            # Special mode to create a playground
            echo "play"
        end 2> /dev/null | sed -e "s|^$HOME|~|" | fzf)

    set selected (echo $selected | sed -e "s|^~|$HOME|")

    if [ -z "$selected" ]
        commandline --function repaint
        return 0
    end

    switch $selected
        case play
            read -P "Give it a name: " name
            if test -z "$name"
                return 0
            else
                set name (snakecase $name)
                set selected ~/playground/$name/
                mkdir -p $selected
            end
    end

    set session_name (echo $selected | tr . _)

    __tmux_register_session $session_name
    __tmux_maybe_create $session_name $selected
    __tmux_attach_or_switch $session_name

end
