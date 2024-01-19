if count $argv >/dev/null
    echo (basename $argv) | sed 's/\.[^.]*$//'
else
    echo "Please supply a path"
    return 1
end
