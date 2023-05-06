function delete_old_tm_backups
    set latest (sudo tmutil latestbackup | sed "s/.*\/\(.*\)\.backup/\1/g")
    set mount_point (sudo tmutil destinationinfo | grep 'Mount Point' | sed "s/.*: \(.*\)/\1/g")
    set backups (sudo tmutil listbackups -t)
    echo $latest
    echo $mount_point
    for backup in $backups
        if test "$backup" != "$latest"
            sudo tmutil delete -d $mount_point -t $backup
        end
    end
end
