alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'

if not uname -a | grep -qi "darwin"
	alias chmod='chmod --preserve-root'
	alias chown='chown --preserve-root'
end
