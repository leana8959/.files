function upload
    if count $argv >/dev/null
        set dest_name (file_mantissa $argv)"_"(timestamp)(file_extension $argv)

        rsync -r -v --chown=caddy:caddy --chmod=u=rwX,g=rX,o=rX --exclude ".DS_Store" --update --times --compress --delay-updates \
            $argv \
            earth2077.fr:/srv/http/share/$dest_name

        echo "https://earth2077.fr/share/"$dest_name
    else
        echo "Please append path to a file to be uploaded"
        return 1
    end
end
