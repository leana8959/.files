#!/opt/homebrew/bin/fish
function brew_update
    /opt/homebrew/bin/brew update
    /opt/homebrew/bin/brew upgrade
    /opt/homebrew/bin/brew autoremove
    /opt/homebrew/bin/brew cleanup
end
