function update_dotfiles
    cd $DOTFILES_PATH
    git reset --hard
    git pull origin main
    prevd
end
