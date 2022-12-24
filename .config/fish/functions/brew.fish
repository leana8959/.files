function brew --description "wrapper for brew with pacman syntax"
    if command -v brew >/dev/null
        set -f brew (which brew)
    else
        echo "`brew` is not on this system. Quitting."
        return 1
    end

    if echo $argv | grep -q -- -S
        if echo $argv | grep -q -- -Ss
            $brew search (echo $argv | string replace -r -- "-Ss *" "")
        else if echo $argv | grep -q -- -Scc
            $brew cleanup
        else if echo $argv | grep -Eq -- "-Sy{1,2}u"
            $brew update
            $brew upgrade
        else
            $brew install (echo $argv | string replace -r -- "-S *" "")
        end
    else if echo $argv | grep -q -- -R
        if echo $argv | grep -q -- -Rcns
            $brew rmtree (echo $argv | string replace -r -- "-Rcns *" "")
        else
            $brew remove (echo $argv | string replace -r -- "-R *" "")
        end
    else if echo $argv | grep -q -- -Q
        if echo $argv | grep -Eq -- "-Q [^ ]+"
            $brew info (echo $argv | string replace -r -- "-Q *" "")
        else
            $brew list
        end
    else
        $brew $argv
    end
end
