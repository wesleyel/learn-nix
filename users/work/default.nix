{ pkgs, secrets, lib, ... }:
{
  homeMods = {
    home = rec {
      username = "${secrets.work.username}";
      homeDirectory = "/home/${username}";
      flakeDirectory = "/home/${username}/dotfiles";
    }; 
    btop.enable = true;
    git = {
      enable = true;
      userName = secrets.work.username;
      userEmail = secrets.work.email;
    };
  };
  home.packages = with pkgs; [
    
  ];
  home.stateVersion = "22.11";
}
