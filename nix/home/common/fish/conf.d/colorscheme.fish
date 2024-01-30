# Learn more: https://fishshell.com/docs/current/interactive.html

function set_colors
    # scope this in a function to not leak variables everywhere

    set -l black 000000
    set -l grey a0a1a7
    set -l cyan 0184bc
    set -l blue 4078f2
    set -l purple a626a4
    set -l green 50a14f
    set -l orange e45649
    set -l red ca1243
    set -l brown 986801
    set -l gold c18401
    set -l accent 645199
    set -l visual d0d0d0

    ###########
    # General #
    ###########
    # default color
    set -U fish_color_normal $black
    # commands like echo
    set -U fish_color_command $blue
    # keywords like if - this falls back on the command color if unset
    set -U fish_color_keyword $purple
    # quoted text like "abc"
    set -U fish_color_quote $green
    # IO redirections like >/dev/null
    set -U fish_color_redirection $gold
    # process separators like ; and &
    set -U fish_color_end $black --bold
    # syntax errors
    set -U fish_color_error $black
    # ordinary command parameters
    set -U fish_color_param $red
    # parameters that are filenames (if the file exists)
    set -U fish_color_valid_path --italics
    # options starting with “-”, up to the first “--” parameter
    set -U fish_color_option $cyan
    # comments like ‘# important’
    set -U fish_color_comment $grey
    # selected text in vi visual mode
    set -U fish_color_selection --background=$visual
    # parameter expansion operators like * and ~
    set -U fish_color_operator $orange
    # character escapes like \n and \x70
    set -U fish_color_escape $purple
    # autosuggestions (the proposed rest of a command)
    set -U fish_color_autosuggestion $grey
    # The current working directory in the default prompt
    set -U fish_color_cwd $black
    # The current working directory in the default prompt for the root user
    set -U fish_color_cwd_root $red
    # The username in the default prompt
    set -U fish_color_user $grey
    # The hostname in the default prompt
    set -U fish_color_host $black
    # the hostname in the default prompt for remote sessions (like ssh)
    set -U fish_color_host_remote $red
    # the last command’s nonzero exit code in the default prompt
    set -U fish_color_status $red
    # the ‘^C’ indicator on a canceled command
    set -U fish_color_cancel $accent --reverse
    # history search matches and selected pager items (background only)
    set -U fish_color_search_match --background $visual

    #########
    # Pager #
    #########
    # the progress bar at the bottom left corner
    set -U fish_pager_color_progress --reverse $cyan
    # the background color of a line
    set -U fish_pager_color_background $black
    # the prefix string, i.e. the string that is to be completed
    set -U fish_pager_color_prefix $black
    # the completion itself, i.e. the proposed rest of the string
    set -U fish_pager_color_completion $grey
    # the completion description
    set -U fish_pager_color_description $grey
    # background of the selected completion
    set -U fish_pager_color_selected_background $black
    # prefix of the selected completion
    set -U fish_pager_color_selected_prefix
    # suffix of the selected completion
    set -U fish_pager_color_selected_completion $red
    # description of the selected completion
    set -U fish_pager_color_selected_description $gold

    # ## Alternating colors
    # # background of every second unselected completion
    # set -U fish_pager_color_secondary_background --background=$tinted_bg
    # # prefix of every second unselected completion
    # set -U fish_pager_color_secondary_prefix
    # # suffix of every second unselected completion
    # set -U fish_pager_color_secondary_completion
    # # description of every second unselected completion
    # set -U fish_pager_color_secondary_description
end

set_colors
