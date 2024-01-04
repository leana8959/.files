# repo paths
set REPOS_PATH ~/repos
set UNIV_REPOS_PATH ~/univ-repos
set PLAYGROUND_PATH ~/playground
set CODEWARS_PATH ~/codewars
set ZEROJUDGE_PATH ~/zerojudge

set -x EDITOR nvim                                    # Default editor
set -x GPG_TTY (tty)                                  # Set TTY for GPG
set -x fzf_preview_file_cmd 'delta'                   # fzf preview theme (bat)
set -x LS_COLORS (vivid -m 24-bit generate one-light) # fd theme
set fzf_fd_opts --hidden --exclude=.git               # fzf-fish search hidden files
set -x DELTA_FEATURES +side-by-side                   # delta
set -x GOPATH ~/.go                                   # gopath
set -x ANSIBLE_CONFIG ~/.ansible.cfg                  # Ansible path


# fzf layout & theme
set -x FZF_DEFAULT_OPTS '
--cycle
--border=none
--preview-window=wrap
--color=fg:#000000,bg:#eeeeee,hl:#ca1243
--color=fg+:#000000,bg+:#d0d0d0,hl+:#ca1243
--color=info:#0184bc,prompt:#645199,pointer:#645199
--color=marker:#0184bc,spinner:#645199,header:#645199
--color=gutter:#eeeeee'

if status is-interactive
    # OCaml opam environment
    if command -q opam
        eval (opam env)
    end

    # tools
    starship init fish | source
    direnv hook fish | source

    # vi cursor style
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    # iTerm2 intergration
    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
end

