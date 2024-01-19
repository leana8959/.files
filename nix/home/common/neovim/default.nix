{pkgs, ...}: {
  # TODO: actually use nix ?
  home.file = {
    neovim = {
      recursive = true;
      source = ../../../../.config/nvim;
      target = ".config/nvim";
    };
  };

  home.packages = with pkgs; [neovim];
}
