# Universal packages I will want regardless of system, or home-manager profile
pkgs: inputs: with pkgs; [
  git
  curl
  wget
  coreutils-full
  zip
  unzip
  bat
  btop
  tree
  vim
  git-crypt
]
