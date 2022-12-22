alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'

if not string match -qi "*Darwin*" (uname -a)
	# is linux
	alias chmod='chmod --preserve-root'
	alias chown='chown --preserve-root'
end
