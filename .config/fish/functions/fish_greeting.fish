function fish_greeting
    set_color $fish_color_param --bold --italics
    cat ~/TOH-Quotes/* | shuf -n 1
end
