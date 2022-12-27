alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'
alias history='history | nl | tac | less -S +G'


if not uname -a | grep -qi darwin
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
else
    alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
    alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
    alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
end
