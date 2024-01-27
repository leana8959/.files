# vi cursor style
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

set -x EDITOR nvim                                    # Default editor
set -x GPG_TTY (tty)                                  # Set TTY for GPG
set -x fzf_preview_file_cmd 'delta'                   # fzf preview theme (bat)
set -x LS_COLORS (vivid -m 24-bit generate one-light) # fd theme
set fzf_fd_opts --hidden --exclude=.git               # fzf-fish search hidden files
set -x DELTA_FEATURES +side-by-side                   # delta
set -x GOPATH ~/.go                                   # gopath
set -x ANSIBLE_CONFIG ~/.ansible.cfg                  # Ansible path
