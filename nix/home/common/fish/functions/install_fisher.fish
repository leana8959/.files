function install_fisher --description 'Install fisher and its plugins'
    # fisher
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

    # versatile fzf search https://github.com/PatrickF1/fzf.fish
    fisher install PatrickF1/fzf.fish

    # https://github.com/PatrickF1/colored_man_pages.fish
    fisher install patrickf1/colored_man_pages.fish

    # # matching paired symbols https://github.com/laughedelic/pisces
    # fisher install laughedelic/pisces

    # only keep command that succeeded in history
    fisher install meaningful-ooo/sponge

end
