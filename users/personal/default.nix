{
  pkgs,
  secrets,
  lib,
  ...
}:
{
  homeMods = {
    the-secrets = secrets.personal;
    home = rec {
      username = "${the-secrets.username}";
      homeDirectory = "/home/${username}";
      flakeDirectory = "/home/${username}/dotfiles";
    };

    btop.enable = true;
    zsh = {
      enable = true;
      secrets = the-secrets;
    };
    git = {
      enable = true;
      secrets = the-secrets;
    };
  };
  home.packages = with pkgs; [

  ];
  home.stateVersion = "22.11";
}
