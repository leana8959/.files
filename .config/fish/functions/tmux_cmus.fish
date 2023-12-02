function tmux_cmus

    # create session if doesn't exist
    if ! tmux has-session -t="cmus" 2> /dev/null
        tmux new-session -ds "cmus" \; \
            send-keys -t "cmus" cmus ENTER \;
    end

    set -U TMUX_LAST (tmux display-message -p '#S')
    if [ -z $TMUX ]
        tmux attach-session -t "cmus"
    else
        tmux switch-client -t "cmus"
    end

end
