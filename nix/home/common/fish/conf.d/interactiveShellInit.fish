# fzf preview theme (use delta instead of bat)
set -x fzf_preview_file_cmd 'delta'
# fd uses LS_COLORS
set -x LS_COLORS (vivid -m 24-bit generate one-light)
# fzf-fish search hidden files
set -x fzf_fd_opts --hidden --exclude=.git

# bind atuin manually
set -x ATUIN_NOBIND "true"
bind \cr _atuin_search
bind -M insert \cr _atuin_search
