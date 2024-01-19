{pkgs, ...}: {
  home.file = {
    tmux = {
      source = ./tmux.conf;
      target = ".tmux.conf";
    };
  };
  home.packages = [pkgs.tmux];
}
