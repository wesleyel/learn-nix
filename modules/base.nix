{ config, pkgs, ... }:


let
  homeDirectory = builtins.getEnv "HOME";
  username = builtins.getEnv "USER";
in
{
  # 基本信息
  home = {
    username = username;
    homeDirectory = homeDirectory;
    stateVersion = "24.05";
    
    # 设置环境变量
    sessionVariables = {
      EDITOR = "vim";
    };
  };
  
  # 让Home Manager管理自身
  programs.home-manager.enable = true;
} 