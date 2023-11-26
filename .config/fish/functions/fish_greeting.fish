function fish_greeting
    set_color --italics
    switch $FISH_GREETING
    case "toh"
        cat ~/.quotes/toh/* | shuf -n 1
    case "fleabag"
        cat ~/.quotes/fleabag/* | shuf -n 1
    case "date"
        date
    case "citation"
        if type rust_citation 2>&1 > /dev/null
            rust_citation
        else
            ~/.local/bin/citation.py
        end
    case "*"
    end
end
