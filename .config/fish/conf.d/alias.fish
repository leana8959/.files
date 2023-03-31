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

## Git
abbr gaa 'git add (git rev-parse --show-toplevel)'
abbr ga 'git add'
abbr ga. 'git add .'
abbr gc 'git commit'
abbr gca 'git commit -a'
abbr gcaa 'git commit -a --amend'

abbr gcl 'git clone'

abbr gl 'git log'
abbr glf 'git log --follow --'

abbr grs 'git restore'
abbr gch 'git checkout @^ --'

abbr gs 'git switch'
abbr gsc 'git switch -c'

abbr gf 'onefetch'

abbr gp 'git push'
abbr gpr 'git fetch && git rebase'
abbr gpm 'git fetch && git merge'

abbr gr 'git rebase -i'
abbr grc 'git rebase --continue'

## FS
alias tree='tree -Cph -L 1'
abbr t 'tree'
abbr ta 'tree -a'

abbr v='nvim'

abbr d 'cd ~/.dotfiles/.config/'
abbr r 'cd ~/repos/'

## brew
abbr bi 'brew install'
abbr bii 'brew info'
abbr br 'brew rmtree'
abbr bs 'brew search'
abbr B 'brew update && brew upgrade && brew autoremove && brew cleanup'

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
abbr o. 'open .'

## Preferences
abbr vp 'cd ~/.dotfiles/.config/nvim/lua/ && nvim'
abbr fp 'cd ~/.dotfiles/.config/fish/ && nvim config.fish'
