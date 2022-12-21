function ls
tree -Cph -L 1 $argv | less -R
end
