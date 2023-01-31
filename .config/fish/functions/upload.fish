function upload
    if count $argv >/dev/null
        rsync -r -v --chown=caddy:caddy --chmod=u=rwX,g=rX,o=rX --exclude ".DS_Store" --update --times --compress --delay-updates \
            $argv \
            earth2077.fr:/srv/http/share/
        echo -e "\nhttps://earth2077.fr/share/"(path basename $argv)
    else
        echo "Please append path to a file to be uploaded"
    end
end
