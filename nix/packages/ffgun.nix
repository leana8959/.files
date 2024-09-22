# adapted from https://github.com/neXromancers/hacksaw

{
  writeShellApplication,
  shotgun,
  ffmpeg_5-full,
}:

writeShellApplication {
  name = "ffgun";
  runtimeInputs = [
    shotgun
    ffmpeg_5-full
  ];
  text = ''
    dir=/tmp
    current=$(date +%F_%H-%M-%S)

    echo "$dir/$current.mp4"

    hacksaw -n | {
        IFS=+x read -r w h x y

        w=$((w + w % 2))
        h=$((h + h % 2))

        ffmpeg               \
            -v 16            \
            -r 30            \
            -f x11grab       \
            -s "''${w}x''${h}"   \
            -i ":0.0+$x,$y"  \
            -preset slow     \
            -c:v h264        \
            -pix_fmt yuv420p \
            -crf 20          \
            "$dir/$current.mp4"
    }
  '';

  meta.description = "Shotgun's integration script with ffmpeg from their github";
}
