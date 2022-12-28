function add_paths
    contains -- $argv $fish_user_paths
    or set --universal fish_user_paths $fish_user_paths $argv
    echo "Updated PATH: $PATH"
end
