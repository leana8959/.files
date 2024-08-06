function fzf_pass

    set selected \
        (begin
            fd -tf . $PASSWORD_STORE_DIR | sed "s|^$PASSWORD_STORE_DIR/\(.*\)\.gpg\$|\1|"
        end | fzf)

    if [ -z "$selected" ]
        echo Nothing selected
        echo exiting...
    end

    set mode \
        (begin
            echo "password"
            echo "otp"
            echo "all"
        end | fzf)

    switch "$mode"
        case all
            pass Discord/leana | nvim +"setlocal buftype=nofile bufhidden=hide noswapfile"
        case password
            pass "$selected" -c
        case otp
            pass otp "$selected" -c
    end

end
