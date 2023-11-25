function fish_greeting
    set_color --bold --italics
    switch $FISH_GREETING
    case "toh"
        cat ~/.quotes/toh/* | shuf -n 1
    case "fleabag"
        cat ~/.quotes/fleabag/* | shuf -n 1
    case "date"
        date
    case "*"
    end
end
