function install_fisher --description 'Install fisher and its plugins'
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fisher install PatrickF1/fzf.fish # versatile fzf search https://github.com/PatrickF1/fzf.fish
    fisher install patrickf1/colored_man_pages.fish # https://github.com/PatrickF1/colored_man_pages.fish
    fisher install laughedelic/pisces # matching paired symbols https://github.com/laughedelic/pisces
end
