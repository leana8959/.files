function la --wraps='ls -la --color | less -R'
tree -Cpha -L 1 $argv | less -R
end
