{...}: {
  programs = {
    fzf = {
      enable = true;
      defaultOptions = [
        "--cycle"
        "--border=none"
        "--preview-window=wrap"
        "--color=fg:#000000,bg:#eeeeee,hl:#ca1243"
        "--color=fg+:#000000,bg+:#d0d0d0,hl+:#ca1243"
        "--color=info:#0184bc,prompt:#645199,pointer:#645199"
        "--color=marker:#0184bc,spinner:#645199,header:#645199"
        "--color=gutter:#eeeeee"
      ];
    };
  };
}
