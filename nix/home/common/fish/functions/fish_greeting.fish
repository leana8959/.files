    set_color --italics
    switch $FISH_GREETING
    case "toh"
        cat ~/.quotes/toh/* | shuf -n 1
    case "fleabag"
        cat ~/.quotes/fleabag/* | shuf -n 1
    case "date"
        date
    case "citation"
        ~/.local/bin/citation.py
    case "*"
    end
