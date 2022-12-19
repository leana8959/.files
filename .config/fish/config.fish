if status is-interactive
    # Commands to run in interactive sessions can go here
	eval (/opt/homebrew/bin/brew shellenv)
	starship init fish | source
	alias rs_launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
	alias ls='ls -l'
	alias neofetch='neowofetch'
end


