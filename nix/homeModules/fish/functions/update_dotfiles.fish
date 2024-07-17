function update_dotfiles
cd ~/.dotfiles/
git reset --hard
git pull --set-upstream origin main
git submodule update --init
prevd
restow
end
