{
  config,
  lib,
  profile,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.homeMods.home;
in
{
  options.homeMods.home = with lib.types; {
    username = lib.mkOption {
      type = str;
    };
    homeDirectory = lib.mkOption {
      default = "/home/${cfg.username}";
      type = str;
    };
    flakeDirectory = lib.mkOption {
      default = "/home/${cfg.username}/dotfiles";
      type = str;
    };
  };
  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    fonts.fontconfig.enable = true;
    nix = {
      package = pkgs.nix;
      # Enable nix command and flakes
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Pin registry to flake
      registry.nixpkgs.flake = inputs.nixpkgs;
      # Automatic garbase collection
      gc = {
        automatic = true;
        frequency = "weekly";
        options = "--delete-older-than 14d";
      };
    };
    home = {
      username = cfg.username;
      homeDirectory = cfg.homeDirectory;
      # Pin channel to flake
      sessionVariables.NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
      shellAliases = {
        home-switch = "home-manager switch --flake path:${cfg.flakeDirectory}#${profile}";
      };

      packages =
        with pkgs;
        [
        ]
        ++ (import ../shared/packages.nix pkgs inputs);
    };

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.11";
  };
}
