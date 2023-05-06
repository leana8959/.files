function clone_repo
    if count $argv > /dev/null
        set name_repo (echo $argv | sd -p '.*[:/]([\w\d._-]+)/([\w\d._-]+).git$' '$1 $2')
        set name (echo $name_repo | cut -d ' ' -f1)
        set repo (echo $name_repo | cut -d ' ' -f2)
        mkdir -p $REPOS_PATH/$name
        git clone $argv $REPOS_PATH/$name/$repo
    else
        echo "Please provide a git url"
    end
end
