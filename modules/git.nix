{ config, pkgs, ... }:

{
  # Git配置
  programs.git = {
    enable = true;
    userName = "wesleyel";
    userEmail = "48174882+wesleyel@users.noreply.github.com";
    
    # 一些有用的Git配置
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
} 