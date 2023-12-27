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
abbr gc 'git commit'
abbr gcl 'git clone'
abbr gl 'git log'
abbr gs 'git switch'
abbr gp 'git pull'
abbr gP 'git push'
abbr gpr 'git fetch && git rebase'
abbr gpm 'git fetch && git merge'
abbr clone 'clone_to_repos'

## FS
alias tree='tree -Cph'

## Editor
abbr ts tmux_sessionizer
abbr ta tmux_attach
abbr v nvim
abbr x hx
abbr se sudoedit

## brew
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
abbr vp 'cd ~/.dotfiles/.config/nvim/after/plugin && $EDITOR ../../init.lua && prevd'
abbr fp 'cd ~/.dotfiles/.config/fish/functions && $EDITOR ../config.fish && prevd'
abbr tp '$EDITOR ~/.dotfiles/.tmux.conf'
abbr sp '$EDITOR ~/.dotfiles/.config/starship.toml'

# Home-manager
abbr np 'cd ~/.dotfiles/nix && $EDITOR flake.nix && prevd'
abbr hs 'home-manager switch'
abbr ns 'sudo nixos-rebuild switch --flake ~/.dotfiles/nix#thinkpad'

abbr nsh 'nix-shell -p'
alias nix-shell 'nix-shell --run fish'

## Python
abbr vnew 'python3 -m venv venv && source venv/bin/activate.fish'
abbr von 'source venv/bin/activate.fish'
abbr voff 'deactivate'

# Search
abbr s 'search.py'
abbr syt 'search.py -m yt'
abbr sgh 'search.py -m gh'
abbr sfg 'search.py -m fg'
abbr swk 'search.py -m wk'
abbr sge 'search.py -m ge'
