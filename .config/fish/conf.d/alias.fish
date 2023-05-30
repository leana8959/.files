# OS-based aliases
switch (uname)
case "Linux"
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
    abbr ss 'sudo systemctl'
    abbr se 'sudoedit'
case "Darwin"
    alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
    alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
    alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
    alias add_spacer_tile='defaults write com.apple.dock persistent-apps -array-add \'{tile-type="small-spacer-tile";}\'; killall Dock'
end

## Docker
abbr dc 'docker-compose'

## Git
abbr lg 'lazygit'
abbr gaa 'git add (git rev-parse --show-toplevel)'
abbr ga. 'git add .'
abbr gcm 'git commit'
abbr gcl 'git clone'
abbr gl 'git log'
abbr gs 'git switch'
abbr gp 'git push'
abbr gpr 'git fetch && git rebase'
abbr gpm 'git fetch && git merge'
abbr clone 'clone_to_repos'

## FS
alias tree='tree -Cph -L 1'
abbr t 'tree'
abbr d 'cd ~/.dotfiles/.config/'
abbr r 'cd ~/repos/'

## Editor
abbr ts tmux_sessionizer
abbr ta tmux_attach
abbr v nvim

## brew
abbr bis 'brew install'
abbr bif 'brew info'
abbr br 'brew rmtree'
abbr bs 'brew search'
abbr bbb 'brew update && brew upgrade && brew autoremove && brew cleanup'

## Misc
alias restow='cd ~/.dotfiles/ && stow -D . && stow -S . && prevd'
abbr yt 'yt-dlp -f "b" --no-playlist \
-o "~/Downloads/%(title)s.%(ext)s" \
'
abbr ytpl 'yt-dlp -f "b" \
-o "~/Downloads/%(playlist_index)s - %(title)s.%(ext)s" \
'
abbr myip 'curl ipinfo.io'
abbr news newsboat
abbr :q exit
abbr :Q exit

# ssh
abbr pi 'ssh pi4'
abbr mainframe 'ssh mainframe'

## Preferences
abbr vp 'cd ~/.dotfiles/.config/nvim/after/plugin/ && nvim ../../init.lua && prevd'
abbr fp 'cd ~/.dotfiles/.config/fish/ && nvim config.fish && prevd'
abbr tp 'nvim ~/.dotfiles/.tmux.conf'
abbr sp 'nvim ~/.dotfiles/.config/starship.toml'
