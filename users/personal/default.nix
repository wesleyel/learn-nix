{ pkgs, secrets, ... }:
{
  homeMods = {
    home = rec {
      username = "${secrets.personal.username}";
      homeDirectory = "/home/${username}";
      flakeDirectory = "/home/${username}/dotfiles";
    }; 
    btop.enable = true;
  };
  home.packages = with pkgs; [
    
  ];
  programs.git = {
    enable = true;
    userName = secrets.personal.username;
    userEmail = secrets.personal.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  home.stateVersion = "22.11";
}
