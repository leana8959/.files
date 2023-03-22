alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'

alias hist='history | nl | tac | less -S +G'
alias v='nvim'

alias gvim='neovide'
alias cd='z'

# OS-based aliases
if test (uname) = "Linux"
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
else if test (uname) = "Darwin"
    alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
    alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
    alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
end
