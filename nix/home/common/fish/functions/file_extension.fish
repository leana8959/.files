function file_extension --description Obtain\ file\'s\ extension
    if count $argv >/dev/null
        echo (basename $argv) | sed 's/.*\(\.[^.]*$\)/\1/'
    else
        echo "Please supply a path"
        return 1
    end
end
