# Learn more: https://fishshell.com/docs/current/interactive.html

set black 000000
set grey a0a1a7
set cyan 0184bc
set blue 4078f2
set purple a626a4
set green 50a14f
set orange e45649
set red ca1243
set brown 986801
set gold c18401
set accent 645199
set tinted_bg eeeeee

## General
# Default color
set -gx fish_color_normal $black
# Commands (binary)
set -gx fish_color_command $blue
# Options starting with “-”, up to the first “--” parameter
set -gx fish_color_param $red
# Regular command parameters
set -gx fish_color_option $red
# Quoted blocks of text
set -gx fish_color_quote $green
# IO redirections
set -gx fish_color_redirection $gold
# Process separators like ';' and '&'
set -gx fish_color_end $black --bold
# The color used to highlight potential errors (invalid command)
set -gx fish_color_error $red
# Code comments
set -gx fish_color_comment $grey
# Highlight matching parenthesis
set -gx fish_color_match --background=$red
# Used in `dirh` https://fishshell.com/docs/current/cmds/dirh.html
set -gx fish_color_history_current --italics --bold
# Parameter expansion operators like `*` and `~`
set -gx fish_color_operator $blue
# Character escapes like \n
set -gx fish_color_escape $purple
# Parameters that are filenames (if the file exists)
set -gx fish_color_valid_path --underline --bold
# Autosuggestion
set -gx fish_color_autosuggestion $grey
# The `^C` indicator on a canceled command
set -gx fish_color_cancel --reverse $accent
# History search matches and selected pager items (background only)
# Default value is black (background)
set -gx fish_color_search_match --reverse $accent

## Prompt (useless with starship)
# The current working directory in the default prompt
set -gx fish_color_cwd $black
# The current working directory in the default prompt for the root user
set -gx fish_color_cwd_root $black
# The username in the default prompt
set -gx fish_color_user $black
# The hostname in the default prompt
set -gx fish_color_host $black

## Vi
set -gx fish_color_selection --background=$tinted_bg

## Pager
# The progress bar at the bottom left corner
set -gx fish_pager_color_progress --reverse $cyan
# The prefix string, i.e. the string that is to be completed
set -gx fish_pager_color_prefix --bold --underline
# The completion itself, i.e. the proposed rest of the string
set -gx fish_pager_color_completion $black
# The completion description
set -gx fish_pager_color_description $gold --italics #caramel
# Background of the selected completion
set -gx fish_pager_color_selected_background --reverse
