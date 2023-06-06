function update_dotfiles
    cd ~/.dotfiles/
    git reset --hard
    git pull --set-upstream origin main
    prevd
    restow
end
