function install_fisher --description 'Install fisher and its plugins'
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install PatrickF1/fzf.fish
end
