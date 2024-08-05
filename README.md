This repo is managed with Nix + GNU stow

# Hosts
- bismuth : MacBook Pro 2021
- carbon : Thinkpad T470
- tungsten : MacBook Air 2014 (because it gets really hot)
- hydrogen : Raspberry Pi 4
- mertensia : Dell Workstation, Fedora 39

# Linux
- Window Manager : XMonad
- Status Bar : xmobar
- Compositor : picom
- Input Method : fcitx CangJie (Kinda borked and is still a work in progress, but works good enough.)
- Font : hIosevka
- Terminal : Kitty + tmux

# Editors and Shell
- `nvim`:
  Mainly used for Nix, Haskell, Shell, Go, Typst / Markdown. (in order of frequency of use)
- `tmux`
- `fish`
- `starship`

# Nix
## Library
This repository exports some helpful functions that could help reduce the
boilerplate when writing some system configurations with a lot of hosts.
They are exported as a flake module under the attribute `#flakeModules.combinators`

## Packages
This repository exports (some of) my custom packages, notably a customized
iosevka build with ligatures for haskell and some hand-picked glyphs.

## Binary Cache
You should use my binary cache if you're building my fonts, they take a while.
```
https://leana8959.cachix.org
leana8959.cachix.org-1:CxQSAp8lcgMv8Me459of0jdXRW2tcyeYRKTiiUq8z0M=
```

# Layout
My [dvorak french](https://github.com/leana8959/dvorak-french) layout has been
ported to linux using nix.

# Misc utilities
- `cmus`:
  My vim-like bindings and "fixes" for macOS, as well as a customized linux
  script that `notify-send`s the current playing song.

# Theme
I have made a theme (a fork of Atom's one-light) where all my tools are visually
unified. It's neovim part can be found [here](https://github.com/leana8959/curry.nvim).

# Notable shell scripts
All of these are written in fish script. Maybe it's not a good idea, but it's
too late and I want good integration with fish anyway.
- `tmux_sessionizer`: a fish script inspired by
  [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer),
  allows jumping between different tmux sessions using fzf
- `tmux_last`:
  toggle the last tmux session
- `clone_to_repo`:
  clone repository to `~/repos/owner/name`, where I can then attach to using
  sessionizer
The sessionizer primitives starts with two underscores and are reused.


Have fun :)

<!--
vim:textwidth=80
-->
