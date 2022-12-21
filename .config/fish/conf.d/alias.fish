alias neofetch='neowofetch'

if not string match -qi "*Darwin*" (uname -a)
	# is linux
	alias chmod='chmod --preserve-root'
	alias chown='chown --preserve-root'
end
