This folder contains my very awesome dvorak French layout on linux

# Ubuntu
`$XDG_CONFIG_HOME/.config/xkb` doesn't work.
[source](https://github.com/elias19r/xkb-layouts)

`/usr/share/X11/xkb/rules/evdev.xml`
```xml
<layoutList>
...
    <layout>
        <configItem>
            <name>dvorak-french</name>
            <description>French Dvorak</description>
        </configItem>
    </layout>
...
</layoutList>
```

`/usr/share/X11/xkb/rules/evdev.lst`
```xml
! layout
  dvorak-french French Dvorak
```

## Swap escape and capslock
`dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"`

# Notes
Use `setxkbmap -option caps:swapescape` to swap escape and capslock
[source](https://askubuntu.com/a/830343)

## Sources
https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions
