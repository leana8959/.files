function update_dotfiles
    cd ~/.dotfiles/
    git reset --hard
    git pull origin main
    prevd
end
