set name (basename (pwd))
set scope (basename (dirname (pwd)))

git commit -m "add($scope): $name"
