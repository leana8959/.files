function fish_remove_path
    if set index (contains -i $argv[1] $fish_user_path)
        set --erase --universal fish_user_paths[$index]
        echo "Updated fish_user_path: $fish_user_path"
    else
        echo "$argv[1] not found in fish_user_path: $fish_user_path"
    end
end
