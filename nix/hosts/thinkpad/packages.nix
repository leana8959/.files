{
  pkgs,
  agenix,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    vim
    stow
    git
    gcc

    agenix.default
  ];
}
