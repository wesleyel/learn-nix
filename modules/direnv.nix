# 启用direnv配置
{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      # 自动加载.env文件
      use_env() {
        local env_file=''${1:-".env"}
        if [[ -f "$env_file" ]]; then
          watch_file "$env_file"
          dotenv "$env_file"
          log_status "Loaded env from $env_file"
        fi
      }
      
      # 默认自动加载.env文件
      [[ -f .env ]] && use_env
    '';
  };
} 