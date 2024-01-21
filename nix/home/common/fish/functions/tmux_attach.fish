# abandon if tmux not running
set tmux_running (pgrep tmux)
if [ -z "$tmux_running" ]
    return 0
end

set selected (tmux list-sessions -F "#{session_name}" | fzf)
if [ -z $selected ]
    return 0
end

set -Ux TMUX_LAST (tmux display-message -p '#S')

if [ -z $TMUX ]
    tmux attach-session -t $selected
else
    tmux switch-client -t $selected
end
