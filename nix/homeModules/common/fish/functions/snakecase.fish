function snakecase

    echo $argv | sed -E 's/[^A-Za-z0-9_\n]+/_/g' | sed -E 's/__+/_/g' | tr '[:upper:]' '[:lower:]'

end
