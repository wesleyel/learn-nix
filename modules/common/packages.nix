{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # frontend
    bun
    pnpm
    deno
    # backend
    cargo
    rustc
    uv

    # utils
    dust
    eza
    fd
    fzf
    git
    github-cli
    jq
    just
    nixfmt-rfc-style
    p7zip
    python3
    qrencode
    rsync
    tree
    unzip
    vim
    zip
    zsh
  ];
}