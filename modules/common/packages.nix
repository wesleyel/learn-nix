{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    dust
    eza
    fd
    fzf
    git
    github-cli
    jq
    just
    p7zip
    python3
    qrencode
    rsync
    tree
    unzip
    zip
    zsh
  ];
}