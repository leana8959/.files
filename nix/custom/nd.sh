bold=$(tput bold)
normal=$(tput sgr0)

while [ $# -gt 0 ]; do
	case "$1" in
	--clean*)
		shopt -s nullglob
		for link in nix-diff*; do
			set -x
			unlink "$link"
			set +x
		done
		exit 0
		;;
	--last*)
		if [[ "$1" != *=* ]]; then shift; fi
		_last_hash="${1#*=}"
		;;
	--hostname*)
		if [[ "$1" != *=* ]]; then shift; fi
		_hostname="${1#*=}"
		;;
	*)
		printf "Error: unknown argument"
		exit 1
		;;
	esac
	shift
done

echo "Comparing ${bold}$_hostname${normal}'s configuration of ${bold}HEAD${normal} and ${bold}$_last_hash${normal}"

last_ref=".?ref=${_last_hash}#nixosConfigurations.${_hostname}.config.system.build.toplevel"
last_link="nix-diff-${_last_hash:0:7}"
if [ -L "$last_link" ]; then
	echo "Found link ${bold}$last_link${normal}"
else
	echo "Starting configuration build at ${bold}$_last_hash${normal}"
	nix build "$last_ref" --out-link "$last_link" >/dev/null 2>&1 &
fi

echo "Starting configuration build at ${bold}HEAD${normal}"
this_ref=".#nixosConfigurations.${_hostname}.config.system.build.toplevel"
this_link="nix-diff-HEAD"
nix build "$this_ref" --out-link "$this_link" --log-format internal-json --verbose |& nom --json

echo "Waiting for all builds to complete..."
wait
echo "Completed."

echo "Diffing..."
nvd diff "$last_link" "$this_link"
