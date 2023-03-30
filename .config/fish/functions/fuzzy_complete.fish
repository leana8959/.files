function fuzzy_complete
    set -f selected (complete -C | fzf -q (commandline -t) | cut -f1)

    commandline --function repaint
    commandline --current-token --replace -- (string escape -- $selected)
end

