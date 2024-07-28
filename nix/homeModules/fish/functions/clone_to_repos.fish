function clone_to_repos

    if not count $argv >/dev/null
        echo "Git url needed"
    end

    set name_repo (echo $argv | sed -E 's/.*[:\\/]([^\\/]+)\\/([^\\/]+?)(:?.git)?$/\1 \2/')
    set name (echo $name_repo | cut -d ' ' -f1)
    set repo (echo $name_repo | cut -d ' ' -f2)
    mkdir -p $REPOS_PATH/$name
    git clone $argv $REPOS_PATH/$name/$repo

end
