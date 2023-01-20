function snakecase
echo $argv | sed 's/ /_/g' | sed 's/[^A-Za-z0-9_]//g' | tr '[:upper:]' '[:lower:]'
end
