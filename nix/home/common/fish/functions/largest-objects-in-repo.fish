function largest-objects-in-repo
    # Shows you the largest objects in your repo's pack file. Written for osx.
    # @see http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
    # @author Antony Stubbs
    # translated to fish with ChatGPT, reviewed by Léana :P

    # set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
    set -x IFS "\n"

    # list all objects including their size, sort by size, take top 10
    set objects (git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head)

    echo "All sizes are in kB. The pack column is the size of the object, compressed, inside the pack file."

    set output "size,pack,SHA,location"
    for obj in $objects
        # extract the size in bytes
        set size (math (echo $obj | cut -f 5 -d ' ') / 1024)
        # extract the compressed size in bytes
        set compressedSize (math (echo $obj | cut -f 6 -d ' ') / 1024)
        # extract the SHA
        set sha (echo $obj | cut -f 1 -d ' ')
        # find the objects location in the repository tree
        set other (git rev-list --all --objects | grep $sha)
        #lineBreak=`echo -e "\n"`
        set output "$output\n$size,$compressedSize,$other"
    end

    echo -e $output | column -t -s ', '
end
