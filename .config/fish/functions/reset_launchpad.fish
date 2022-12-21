function reset_launchpad --wraps='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock' --description 'Reset launchpad disposition'
    defaults write com.apple.dock ResetLaunchPad -bool true
    killall Dock
end
