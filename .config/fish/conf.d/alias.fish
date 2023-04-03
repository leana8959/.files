# OS-based aliases
switch $uname
    case "Linux"
        alias chmod='chmod --preserve-root'
        alias chown='chown --preserve-root'
    case "Darwin"
        alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
        alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
        alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
        alias add_spacer_tile='defaults write com.apple.dock persistent-apps -array-add \'{tile-type="small-spacer-tile";}\'; killall Dock'
end

## Git
abbr gaa 'git add (git rev-parse --show-toplevel)'
abbr ga. 'git add .'
abbr gcm 'git commit'
abbr gcl 'git clone'
abbr gl 'git log'
abbr gs 'git switch'
abbr gp 'git push'
abbr gpr 'git fetch && git rebase'
abbr gpm 'git fetch && git merge'

## FS
alias tree='tree -Cph -L 1'
abbr t 'tree'
abbr d 'cd ~/.dotfiles/.config/'
abbr r 'cd ~/repos/'

## Editor
abbr ts tmux_sessionizer
abbr ta tmux_attach
abbr v tmux_sessionizer nvim

## brew
abbr bis 'brew install'
abbr bif 'brew info'
abbr br 'brew rmtree'
abbr bs 'brew search'
abbr bbb 'brew update && brew upgrade && brew autoremove && brew cleanup'

## Misc
abbr yt 'yt-dlp \
--merge-output-format "mkv" \
-f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" \
-o "/Users/leana/Downloads/%(title)s.%(ext)s" \
'
abbr ip 'curl ipinfo.io'
abbr k 'killall'
abbr o 'open'
abbr o. 'open .'
abbr :q exit
abbr :Q exit

## Preferences
abbr vp 'cd ~/.dotfiles/.config/nvim/lua/ && nvim && cd'
abbr fp 'cd ~/.dotfiles/.config/fish/ && nvim config.fish && cd'
abbr tp 'nvim ~/.dotfiles/.tmux.conf'
abbr sp 'nvim ~/.dotfiles/.config/starship.toml'
