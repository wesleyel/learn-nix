{ config, pkgs, lib, envVars, ... }:

let
  # 首先尝试从传入的envVars中读取，如果没有则回退到环境变量
  gitUserName = if envVars ? GIT_USER_NAME then envVars.GIT_USER_NAME else config.git.userName;
  gitUserEmail = if envVars ? GIT_USER_EMAIL then envVars.GIT_USER_EMAIL else config.git.userEmail;
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