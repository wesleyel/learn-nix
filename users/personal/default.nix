{ pkgs, secrets, lib, ... }:
{
  homeMods = {
    home = rec {
      username = "${secrets.personal.username}";
      homeDirectory = "/home/${username}";
      flakeDirectory = "/home/${username}/dotfiles";
    }; 
    btop.enable = true;
    git = {
      enable = true;
      userName = secrets.personal.username;
      userEmail = secrets.personal.email;
    };
  };
  home.packages = with pkgs; [
    
  ];
  home.stateVersion = "22.11";
}
