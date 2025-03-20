{
  description = "Home Manager 配置";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      globals = {
        # Shhhhh
        # Semi-private files encrypted with git-crypt. Profiles relying on these files will fail if not decrypted first.
        # Read all the files, and mush them into a top level hush attribute set; Expects TOML format
        secrets =
          let
            dir = ./secrets;
            temp = { };
          in
          builtins.head (
            map (x: temp // (inputs.nixpkgs.lib.importTOML "${dir}/${x}")) (
              builtins.attrNames (builtins.readDir dir)
            )
          );
      };
    in
    rec {
      darwinConfigurations = {
        home-darwin = import ./hosts/home-darwin { inherit inputs globals; };
      };

      homeConfigurations = {
        home-work = import ./hosts/home-work { inherit inputs globals; };
        home-darwin = darwinConfigurations.home-darwin.home-manager.users.${darwinConfigurations.home-darwin.secrets.username}.home;
      };
    };
}
