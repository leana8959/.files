function fish_greeting
    switch $greeting
        case "TOH"
            set_color $fish_color_option --bold --italics
            cat ~/TOH-Quotes/* | shuf -n 1
    end
end
