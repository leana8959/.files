function file_mantissa --description 'Obtain file name without extension'
    if count $argv >/dev/null
        echo (basename $argv) | sed 's/\.[^.]*$//'
    else
        echo "Please supply a path"
        return 1 
    end
end
