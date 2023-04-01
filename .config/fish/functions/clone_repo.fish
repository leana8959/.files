function clone_repo
    if count $argv > /dev/null
        set -f name_repo (echo $argv | sd -p '.*[:/]([\w\d._-]+)/([\w\d._-]+).git$' '$1 $2')
        set -f name (echo $name_repo | cut -d ' ' -f1)
        set -f repo (echo $name_repo | cut -d ' ' -f2)
        mkdir -p ~/repos/"$name"
        git clone $argv ~/repos/"$name"/"$repo"
        cd ~/repos/"$name"/"$repo"
    else
        echo "Please provide a git url"
    end
end
