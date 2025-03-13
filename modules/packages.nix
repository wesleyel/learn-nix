{ config, pkgs, ... }:

{
  # 安装的软件包
  home.packages = with pkgs; [
    # 常用工具
    bat
    ripgrep
    git
    direnv
  ];
} 