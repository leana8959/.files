function snakecase
    echo $argv | sd -p '[^A-Za-z0-9_\n]' '_' | sd -p '__+' '_' | tr '[:upper:]' '[:lower:]'
end
