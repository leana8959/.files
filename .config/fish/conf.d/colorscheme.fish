# Learn more: https://fishshell.com/docs/current/interactive.html

## General
# Default color
set -gx fish_color_normal normal
# Commands (binary)
set -gx fish_color_command 000000 #black
# Options starting with “-”, up to the first “--” parameter
set -gx fish_color_param 000000 #black
# Regular command parameters
set -gx fish_color_option 875fff #purple
# Quoted blocks of text
set -gx fish_color_quote ff5f00 #orange
# IO redirections
set -gx fish_color_redirection d78700 #caramel
# Process separators like ';' and '&'
set -gx fish_color_end d78700 #caramel
# The color used to highlight potential errors (invalid command)
set -gx fish_color_error c82829 #crimson
# Code comments
set -gx fish_color_comment a8a8a8 #grey
# Highlight matching parenthesis
set -gx fish_color_match --background=brblue
# Used in `dirh` https://fishshell.com/docs/current/cmds/dirh.html
set -gx fish_color_history_current --italics --bold
# Parameter expansion operators like `*` and `~`
set -gx fish_color_operator 00a6b2 #teal
# Character escapes like \n
set -gx fish_color_escape 00a6b2 #teal
# Parameters that are filenames (if the file exists)
set -gx fish_color_valid_path --underline
# Autosuggestion
set -gx fish_color_autosuggestion d7afff #violet
# The `^C` indicator on a canceled command
set -gx fish_color_cancel ff5f00 --reverse #orange
# History search matches and selected pager items (background only)
# Default value is black (background)
set -gx fish_color_search_match --reverse

## Prompt (useless with starship)
# The current working directory in the default prompt
set -gx fish_color_cwd normal
# The current working directory in the default prompt for the root user
set -gx fish_color_cwd_root normal
# The username in the default prompt
set -gx fish_color_user normal
# The hostname in the default prompt
set -gx fish_color_host normal

## Pager
# The progress bar at the bottom left corner
set -gx fish_pager_color_progress 00a6b2 --reverse #teal
# The prefix string, i.e. the string that is to be completed
set -gx fish_pager_color_prefix --bold --underline
# The completion itself, i.e. the proposed rest of the string
set -gx fish_pager_color_completion normal
# The completion description
set -gx fish_pager_color_description d78700 --italics #caramel
# Background of the selected completion
set -gx fish_pager_color_selected_background --reverse

