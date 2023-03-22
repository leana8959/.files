function sync_notes
    rsync --recursive --verbose --chown=caddy:caddy --chmod=u=rwX,g=rX,o=rX --exclude=".DS_Store" --update --times --compress --delay-updates --delete \
        /Users/leana/Documents/Rennes\ 1/L2/Prise\ de\ notes/ \
        earth2077.fr:/srv/http/notes/
end
