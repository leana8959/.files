function fish_command_not_found

    set hour (date +"%H")
    set user (whoami)

    set words                              \
            "Are you drunk ??"             \
            "Il est seulement $hour heure" \
            "Reveille-toi, $user"          \
            "Magique de vim !"             \
            "As-tu ecris ton journal aujourd'hui ?"

    set choice $words[(random 1 (count $words))]

    echo -e $choice | figlet -c

end
