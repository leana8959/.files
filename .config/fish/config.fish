if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx GPG_TTY (tty)
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

