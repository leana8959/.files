This repo is managed with Nix + GNU stow (for neovim)

# Editors and Shell
- `nvim`:
  Mainly used for Haskell, Rust, Java, Typst, Scala. (in order of frequency of
  use)
- `starship`
- `fish`

# Packages
This repository exports (some of) my custom packages.
For example, use
```bash
nix build -L "git+https://git.earth2077.fr/leana/.files?dir=nix#hiosevka-nerd-font-mono"
```
To build hIosevka Nerd Font, Iosevka with Haskell ligatures. [^1]

# Layout
My [dvorak french](https://github.com/leana8959/dvorak-french) layout has been
ported to linux using nix.

# Theme
I have made a theme (a fork of Atom's one-light) all my tools are visually
unified.

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

# Linux
Rarely used since I don't have enough time to figure my way out on linux
completly, sadly.
- `xmonad`
- `xmobar`
- `fcitx`: CangJie (倉頡) input method

# Misc
- `cmus`:
  My vim-like bindings and fixes for macOS

Have fun :)


[^1]: "Mono" means that the icons are of single width. Read more [here](https://github.com/ryanoasis/nerd-fonts/wiki/ScriptOptions)

<!--
vim:textwidth=80
-->
