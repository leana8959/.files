if status is-interactive
    # Set editor
    set -gx EDITOR nvim

    # Set TTY for GPG
    set -gx GPG_TTY (tty)

    # Set fzf layout & theme
    set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"'
    set -gx fzf_preview_file_cmd "bat --style=numbers --color=always --theme OneHalfLight"

    # Set fd theme
    set -gx LS_COLORS (vivid -m 24-bit generate one-light)

    # Source starship
    starship init fish | source

    # Source zoxide
    zoxide init fish --hook="prompt" | source
end

# iTerm2 intergration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

