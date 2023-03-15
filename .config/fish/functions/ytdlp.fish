function ytdlp
    yt-dlp \
    --merge-output-format "mkv" \
    -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" \
    -o "/Users/leana/Downloads/%(title)s.%(ext)s" \
    $argv
end
