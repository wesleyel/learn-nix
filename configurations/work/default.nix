{ config, pkgs, lib, ... }:

let
  gitUserName = builtins.getEnv "GIT_USER_NAME";
  gitUserEmail = builtins.getEnv "GIT_USER_EMAIL";
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