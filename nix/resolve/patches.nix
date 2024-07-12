_: prev: {
  # https://github.com/tmux/tmux/issues/3983
  # fix tmux crashing when neovim is used in a nested session
  tmux = prev.tmux.overrideAttrs (oa: {
    patches = (oa.patches or [ ]) ++ [
      (prev.fetchpatch {
        name = "sixel-patch";
        url = "https://github.com/tmux/tmux/commit/aa17f0e0c1c8b3f1d6fc8617613c74f07de66fae.patch";
        hash = "sha256-jhWGnC9tsGqTTA5tU+i4G3wlwZ7HGz4P0UHl17dVRU4=";
      })
    ];
  });
}
