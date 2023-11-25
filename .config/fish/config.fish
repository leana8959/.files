# repo paths
# tmux_sessionizer is run in non-interactive mode
set REPOS_PATH ~/repos
set UNIV_REPOS_PATH ~/univ-repos
set PLAYGROUND_PATH ~/playground
set CODEWARS_PATH ~/codewars
set ZEROJUDGE_PATH ~/zerojudge

if status is-interactive
    # Default editor
    set -x EDITOR nvim

    # Set TTY for GPG
    set -x GPG_TTY (tty)

    # fzf layout & theme
    set -x FZF_DEFAULT_OPTS '
    --cycle
    --layout=reverse
    --border=sharp
    --height=90%
    --preview-window=wrap
    --color=fg:#383A42,bg:#eeeeee,hl:#ca1243
    --color=fg+:#383A42,bg+:#d0d0d0,hl+:#ca1243
    --color=info:#0184bc,prompt:#645199,pointer:#645199
    --color=marker:#0184bc,spinner:#645199,header:#645199
    --color=gutter:#eeeeee'

    # fzf preview theme (bat)
    set -x fzf_preview_file_cmd 'delta'

    # fd theme
    set -x LS_COLORS (vivid -m 24-bit generate one-light)

    # fzf-fish search hidden files
    set fzf_fd_opts --hidden --exclude=.git

    # delta
    set -x DELTA_FEATURES +side-by-side

    # gopath
    set -x GOPATH ~/.go

    # vi cursor style
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    # OCaml opam environment
    if command -q opam
        eval (opam env)
    end

    # Ansible path
    set -x ANSIBLE_CONFIG ~/.ansible.cfg

    # tools
    starship init fish | source

    # call tmux_home
    if [ -z $TMUX ]
        tmux_home
    end

else # non-interactive

    # fzf layout & theme
    set FZF_DEFAULT_OPTS '
    --cycle
    --border=sharp
    --height=90%
    --preview-window=wrap
    --color=fg:#383A42,bg:#eeeeee,hl:#ca1243
    --color=fg+:#383A42,bg+:#d0d0d0,hl+:#ca1243
    --color=info:#0184bc,prompt:#645199,pointer:#645199
    --color=marker:#0184bc,spinner:#645199,header:#645199
    --color=gutter:#eeeeee'

end

# iTerm2 intergration
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
