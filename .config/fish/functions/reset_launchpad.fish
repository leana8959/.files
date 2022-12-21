function reset_launchpad --wraps='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock' --description 'alias reset_launchpad=defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
  defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock $argv; 
end
