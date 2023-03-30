# Aliases
alias t='tree -Cph -L 1'
alias ta='tree -Cpha -L 1'

alias v='nvim'

# Abbreviations
## Git
abbr ga 'git add'
abbr ga. 'git add .'
abbr gc 'git commit'
abbr gca 'git commit -a'
abbr gcaa 'git commit -a --amend'

abbr gl 'git log'
abbr glf 'git log --follow -- '

abbr gr 'git restore'

abbr gs 'git switch'
abbr gsc 'git switch -c'

abbr gf 'onefetch'

abbr gp 'git push'
abbr gr 'git fetch && git rebase'
abbr gm 'git fetch && git merge'

## FS
abbr d 'cd ~/.dotfiles/.config/'
abbr df 'cd ~/.dotfiles/.config/fish/'
abbr dv 'cd ~/.dotfiles/.config/nvim/lua'
abbr r 'cd ~/repos/'

## brew
abbr bi 'brew install'
abbr br 'brew rmtree'
abbr bs 'brew search'

## Misc
abbr yt 'yt-dlp \
--merge-output-format "mkv" \
-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" \
-o "/Users/leana/Downloads/%(title)s.%(ext)s" \
'
abbr ip 'curl ipinfo.io'
abbr ts 'date +%s'
abbr k 'killall'
abbr o 'open'


# OS-based aliases
if test (uname) = "Linux"
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
else if test (uname) = "Darwin"
    alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
    alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
    alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
    alias add_spacer_tile='defaults write com.apple.dock persistent-apps -array-add \'{tile-type="small-spacer-tile";}\'; killall Dock'

else
    # Neither, do nothing
end
