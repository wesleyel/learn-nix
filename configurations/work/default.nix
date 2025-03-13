{ config, pkgs, lib, envVars, ... }:

let
  # 使用环境变量或默认值
  gitUserName = if envVars ? GIT_USER_NAME then envVars.GIT_USER_NAME else "Default User";
  gitUserEmail = if envVars ? GIT_USER_EMAIL then envVars.GIT_USER_EMAIL else "default@example.com";
in
{
  imports = [
    ../../modules
  ];

  programs.git = {
    userName = lib.mkForce gitUserName;
    userEmail = lib.mkForce gitUserEmail;
  };
}