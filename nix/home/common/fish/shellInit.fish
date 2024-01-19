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
