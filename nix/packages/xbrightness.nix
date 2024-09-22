{
  writeShellApplication,

  bc,
}:

writeShellApplication {
  name = "xbrightness";
  runtimeInputs = [ bc ];
  text = ''
    device=$1
    rel=$2
    brightness=$(xrandr --verbose | grep Brightness | cut -d':' -f 2)
    xrandr --output "$device" --brightness "$(echo "$brightness $rel" | bc -l)"
  '';
}
