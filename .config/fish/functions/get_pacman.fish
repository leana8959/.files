function get_pacman
    if command -v brew >/dev/null
        brew $argv
    else if command -v pacman >/dev/null
        pacman $argv
    else
        echo "Unknown package manager, quitting."
        return 1
    end
end
