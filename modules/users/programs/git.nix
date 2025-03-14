{ config, pkgs, lib, ... }:
let
  cfg = config.homeMods.git;
in
{
  options.homeMods.git = with lib.types; {
    enable = lib.mkEnableOption "Enable"; 
    userName = lib.mkOption {
      type = str;
      default = "";
      description = "Git user name";
    };
    userEmail = lib.mkOption {
      type = str;
      default = "";
      description = "Git user email";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        init.defaultBranch = "main";
        branch.autosetuprebase = "always";
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };
  };
}
