alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'
alias history='history | nl | less +G'

if not uname -a | grep -qi "darwin"
	alias chmod='chmod --preserve-root'
	alias chown='chown --preserve-root'
end
