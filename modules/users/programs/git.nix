{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeMods.git;
in
{
  options.homeMods.git = with lib.types; {
    enable = lib.mkEnableOption "Enable";
    secrets = lib.mkOption {
      type = types.attrs;
      description = "Git secrets configuration";
      default = { };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.secrets.username;
      userEmail = cfg.secrets.email;
      extraConfig = {
        init.defaultBranch = "main";
        branch.autosetuprebase = "always";
        push.autoSetupRemote = true;
        pull.rebase = true;
        credential.helper = [
          "cache --timeout 21600"
          "oauth"
        ];
      };
      aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        lgl = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      };
    };
    programs.git-credential-oauth = {
      enable = true;

    }
  };
}
