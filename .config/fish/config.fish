if status is-interactive
    # Default editor
    set -gx EDITOR nvim

    # Set TTY for GPG
    set -g GPG_TTY (tty)

    # fzf layout & theme
    set -g FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"
    --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
    --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
    --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
    --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'

    # fzf preview theme (bat)
    set -g fzf_preview_file_cmd 'delta'

    # fd theme
    set -g LS_COLORS (vivid -m 24-bit generate one-light)

    # repo paths
    # universal because tmux_sessionizer is run in non-interactive mode
    set -U REPOS_PATH ~/repos
    set -U UNIV_REPOS_PATH ~/univ-repos
    set -U PLAYGROUND_PATH ~/playground
    set -U CODEWARS_PATH ~/codewars
    set -U ZEROJUDGE_PATH ~/zerojudge

    # delta
    set -g DELTA_FEATURES +side-by-side

    # gopath
    set -g GOPATH ~/.go

    # vi cursor style
    fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block

    # OCaml opam environment
    if command -q opam
        eval (opam env)
    end

    # Ansible path
    set -g ANSIBLE_CONFIG ~/.ansible.cfg

    # tools
    starship init fish | source

    # call tmux_home
    if [ -z $TMUX ]
        tmux_home
    end

end

# iTerm2 intergration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
