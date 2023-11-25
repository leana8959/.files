# Learn more: https://fishshell.com/docs/current/interactive.html

set black 383A42
set white ffffff
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
set visual d0d0d0

###########
# General #
###########
# default color
set -g fish_color_normal $black
# commands like echo
set -g fish_color_command $blue
# keywords like if - this falls back on the command color if unset
set -g fish_color_keyword $purple
# quoted text like "abc"
set -g fish_color_quote $green
# IO redirections like >/dev/null
set -g fish_color_redirection $gold
# process separators like ; and &
set -g fish_color_end $black --bold
# syntax errors
set -g fish_color_error $grey --underline
# ordinary command parameters
set -g fish_color_param $red
# parameters that are filenames (if the file exists)
set -g fish_color_valid_path --italics
# options starting with “-”, up to the first “--” parameter
set -g fish_color_option $red
# comments like ‘# important’
set -g fish_color_comment $grey
# selected text in vi visual mode
set -g fish_color_selection --background=$visual
# parameter expansion operators like * and ~
set -g fish_color_operator $orange
# character escapes like \n and \x70
set -g fish_color_escape $purple
# autosuggestions (the proposed rest of a command)
set -g fish_color_autosuggestion $accent
# The current working directory in the default prompt
set -g fish_color_cwd $black
# The current working directory in the default prompt for the root user
set -g fish_color_cwd_root $red
# The username in the default prompt
set -g fish_color_user $grey
# The hostname in the default prompt
set -g fish_color_host $black
# the hostname in the default prompt for remote sessions (like ssh)
set -g fish_color_host_remote $red
# the last command’s nonzero exit code in the default prompt
set -g fish_color_status $red
# the ‘^C’ indicator on a canceled command
set -g fish_color_cancel $accent --reverse
# history search matches and selected pager items (background only)
set -g fish_color_search_match --reverse

#########
# Pager #
#########
# the progress bar at the bottom left corner
set -g fish_pager_color_progress --reverse $cyan
# the background color of a line
set -g fish_pager_color_background $black
# the prefix string, i.e. the string that is to be completed
set -g fish_pager_color_prefix $black
# the completion itself, i.e. the proposed rest of the string
set -g fish_pager_color_completion $grey
# the completion description
set -g fish_pager_color_description $grey
# background of the selected completion
set -g fish_pager_color_selected_background $black
# prefix of the selected completion
set -g fish_pager_color_selected_prefix
# suffix of the selected completion
set -g fish_pager_color_selected_completion $red
# description of the selected completion
set -g fish_pager_color_selected_description $gold
# ## Alternating colors
# # background of every second unselected completion
# set -g fish_pager_color_secondary_background --background=$tinted_bg
# # prefix of every second unselected completion
# set -g fish_pager_color_secondary_prefix
# # suffix of every second unselected completion
# set -g fish_pager_color_secondary_completion
# # description of every second unselected completion
# set -g fish_pager_color_secondary_description
