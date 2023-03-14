if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx GPG_TTY (tty)
    set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"'
    set -gx fzf_preview_file_cmd "bat --style=numbers --color=always --theme OneHalfLight"
    set -gx LS_COLORS (vivid -m 24-bit generate one-light)
	set -gx EDITOR nvim
end

test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
