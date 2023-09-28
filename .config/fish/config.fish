if status is-interactive
    # Default editor
    set -gx EDITOR nvim

    # Set TTY for GPG
    set -gx GPG_TTY (tty)

    # fzf layout & theme
    set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"
    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'
    # fzf preview theme (bat)
    set -gx fzf_preview_file_cmd 'bat --style=numbers --color=always --theme OneHalfLight'

    # fd theme
    set -gx LS_COLORS (vivid -m 24-bit generate one-light)

    # repo paths
    # universal because tmux_sessionizer is run in non-interactive mode
    set -Ux REPOS_PATH ~/repos
    set -Ux UNIV_REPOS_PATH ~/univ-repos
    set -Ux PLAYGROUND_PATH ~/playground
    set -Ux CODEWARS_PATH ~/codewars
    set -Ux ZEROJUDGE_PATH ~/zerojudge

    # gopath
    set -gx GOPATH ~/.go

    # vi cursor style
    fish_vi_key_bindings
    set -gx fish_cursor_default block
    set -gx fish_cursor_insert line
    set -gx fish_cursor_replace_one underscore
    set -gx fish_cursor_visual block

    # Java Home
    set -x JAVA_HOME (/usr/libexec/java_home -v 17)
    alias java $JAVA_HOME/bin/java

    # SBT JVM setting
    alias sbt "sbt -java-home $JAVA_HOME"

    # Ansible path
    set -gx ANSIBLE_CONFIG ~/.ansible.cfg

    # tools
    starship init fish | source
    zoxide init fish --hook=prompt | source
end

# iTerm2 intergration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
