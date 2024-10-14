{
  writeShellApplication,

  sane-backends,
  poppler_utils,
  fzf,
  ghostscript,
}:

writeShellApplication {
  name = "easyscan";

  runtimeInputs = [
    sane-backends
    poppler_utils
    fzf
    ghostscript
  ];

  text = ''
    tempdir=$(mktemp -d)

    device=$(scanimage --list-devices |
    	sed -e "s/.*\`//" |
    	sed -e "s/'.*//" |
    	fzf --header "Pick a device:")

    do_scan() {
    	filename="$tempdir/$(date).pdf"
    	while ! scanimage --format=pdf --device="$device" --resolution 300 >"$filename"; do
    		:
    	done
    	echo "$filename"
    }

    do_fix() {
    	read -r filename
    	fixed_name="''${filename%.pdf}_fixed.pdf"
    	gs -o "$fixed_name" -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress "$filename"
    	rm "$filename"
    	mv "$fixed_name" "$filename"
    	echo "$filename"
    }

    while IFS= read -r -p "Continue scanning ? [Y/n]" cont; do
    	case "$cont" in
    	[nN])
    		echo "Exiting..."
    		break
    		;;
    	[yY] | *)
    		do_scan | do_fix
    		;;
    	esac
    done

    # Multiple files are scanned, join them
    final_filename="$tempdir/$(date)_final.pdf"
    pdfunite "$tempdir"/*.pdf "$final_filename"
    echo "$final_filename" | do_fix

    # Copy scan to current directory
    cp "$final_filename" "./scan_$(date).pdf"
  '';

}
