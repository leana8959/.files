function sync_note
    echo ===== (date) =====
    /opt/homebrew/bin/rsync -r -v --chown=caddy:caddy --chmod=u=rX,g=rX,o=rX --exclude ".DS_Store" --update --times --compress --delay-updates \
        /Users/leana/Documents/Rennes\ 1/L2/Prise\ de\ notes/ \
        earth2077.fr:/srv/http/notes/
end
