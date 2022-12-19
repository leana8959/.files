function add_spacer_tile
    defaults write com.apple.dock persistent-apps -array-add '{tile-type="small-spacer-tile";}'
    killall Dock
end
