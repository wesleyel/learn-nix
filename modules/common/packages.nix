{ config, pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    # frontend
    bun
    pnpm
    deno
    nodejs_22

    # backend
    rustup
    uv
    python312
    python312Packages.pandas
    python312Packages.numpy
    python312Packages.matplotlib

    # utils
    direnv
    dust
    eza
    fd
    fzf
    git
    git-crypt
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

    # nix
    home-manager
    nix-direnv
  ];
}