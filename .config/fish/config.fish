if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx GPG_TTY (tty)
    # Default setting for fzf plugin
    set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --preview-window="bottom"'
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

