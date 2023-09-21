# OS-based aliases
switch (uname)
case "Linux"
    alias chmod='chmod --preserve-root'
    alias chown='chown --preserve-root'
    abbr ss 'sudo systemctl'
case "Darwin"
    alias hide_desktop='defaults write com.apple.finder CreateDesktop false; killall Finder'
    alias show_desktop='defaults write com.apple.finder CreateDesktop true; killall Finder'
    alias reset_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
    alias add_spacer_tile='defaults write com.apple.dock persistent-apps -array-add \'{tile-type="small-spacer-tile";}\'; killall Dock'
end

## Docker
abbr dc 'docker-compose'

## Git
abbr gaa 'git add (git rev-parse --show-toplevel)'
abbr ga. 'git add .'
abbr gcm 'git commit'
abbr gcl 'git clone'
abbr gl 'git log'
abbr gsw 'git switch'
abbr gp 'git pull'
abbr gP 'git push'
abbr gpr 'git fetch && git rebase'
abbr gpm 'git fetch && git merge'
abbr clone 'clone_to_repos'

## FS
alias tree='tree -Cph -L 1'

## Editor
abbr ts tmux_sessionizer
abbr ta tmux_attach
abbr v nvim
abbr x hx

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
alias :w 'echo "Are you drunk??"'

# ssh
abbr pi 'ssh pi4'
abbr mainframe 'ssh mainframe'

## Preferences
abbr vp 'cd ~/.dotfiles/.config/nvim/after/plugin/ && $EDITOR ../../init.lua && prevd'
abbr xp 'cd ~/.dotfiles/.config/helix && $EDITOR config.toml && prevd'
abbr fp 'cd ~/.dotfiles/.config/fish/ && $EDITOR config.fish && prevd'
abbr tp '$EDITOR ~/.dotfiles/.tmux.conf'
abbr sp '$EDITOR ~/.dotfiles/.config/starship.toml'

## Python
abbr vv 'python3 -m venv venv && source venv/bin/activate.fish'
abbr von 'source venv/bin/activate.fish'
abbr voff 'deactivate'
