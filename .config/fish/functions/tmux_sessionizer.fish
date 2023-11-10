# Inspired by the one and only primeagen

function tmux_sessionizer --description "create tmux sessions"
    set selected \
        # {{{
        (begin
            # use fd even thought it's an extra dependency because find is too slow
            fd . $REPOS_PATH $UNIV_REPOS_PATH --exact-depth 2 --type d;
            fd . $PLAYGROUND_PATH --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Haskell --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Rust --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Python --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/C --exact-depth 1 --type d;
            fd . $CODEWARS_PATH/Shell --exact-depth 1 --type d;
            fd . $ZEROJUDGE_PATH --exact-depth 1 --type d;
            echo "play";
            echo "codewars haskell";
            echo "codewars rust";
            echo "codewars python";
            echo "codewars c";
            echo "codewars shell";
            echo "zerojudge c";
        end 2> /dev/null | fzf)
        # }}}

    if [ -z $selected ]
        commandline --function repaint
        return 0
    end

    switch $selected
    case "play"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected ~/playground/$name/
            mkdir -p $selected
        end
        # }}}

    case "codewars rust"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set kata_name (snakecase $name)
            set selected $CODEWARS_PATH/Rust/$kata_name/
            cargo new $selected --name codewars_$kata_name --vcs none
        end
        # }}}

    case "codewars python"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/Python/$name/
            mkdir -p $selected
            touch $selected/main.py
        end
        # }}}

    case "codewars haskell"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/Haskell/$name

            mkdir -p $selected
            set output (cd $selected && cabal init --non-interactive)
            set filename (echo $output | grep -E -o "[A-Za-z0-9-]+\.cabal")
            sed -i '' \
                -E 's/^.*build-depends:.*$/    build-depends:\n        base ^>=4.17.0.0,\n        QuickCheck,\n        hspec,/' \
                "$selected/$filename"
        end
        # }}}

    case "codewars c"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/C/$name/
            mkdir -p $selected
            touch $selected/main.c
            echo "run:
	gcc -I/opt/homebrew/include -L/opt/homebrew/lib -lcriterion main.c
	./a.out" > $selected/makefile
        end
        # }}}

    case "codewars shell"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set name (snakecase $name)
            set selected $CODEWARS_PATH/Shell/$name/
            mkdir -p $selected
            touch $selected/main.sh
        end
        # }}}

    case "zerojudge c"
        # {{{
        read -P "Give it a name: " name
        if test -z $name
            return 0
        else
            set selected $ZEROJUDGE_PATH/$name/
            mkdir -p $selected
            touch $selected/main.c
        end
        # }}}
    end

    set session_name (echo $selected | tr . _)

    # create session if doesn't exist
    if ! tmux has -t=$session_name 2> /dev/null
        tmux \
            new-session -ds $session_name -c $selected \; \
            send-keys -t $session_name $EDITOR ENTER \; \
            new-window -t $session_name -c $selected \; \
            select-window -t $session_name:1 \;
    end

    set -U TMUX_LAST (tmux display-message -p '#S')
    if [ -z $TMUX ]
        tmux attach-session -t $session_name
    else
        tmux switch-client -t $session_name
    end

end

# vim:foldmethod=marker:foldlevel=0
