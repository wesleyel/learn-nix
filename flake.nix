{
  description = "Home Manager 配置";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
     # replace official cache with a mirror located in China
     "https://mirrors.ustc.edu.cn/nix-channels/store"
     "https://cache.nixos.org/"
    ];

    # nix communitys cache server
    # extra-substituters = [
    #   "https://hadolint.cachix.org"
    # ];
    # extra-trusted-public-keys = [
    #   "hadolint.cachix.org-1:CdmLJ7MXh5ojKBPUQGYklkbetIdIcC8tgOTGRUnxBjo="
    # ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "wesley" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ({pkgs, ...}: {
            nix.package = pkgs.nix;
            nixpkgs.config.allowUnfree = true;
            home.username = "yangxn";
            home.homeDirectory = "/home/yangxn";
            imports = [
              ./system/linux/home.nix
            ];
          })
        ];
      };
    };
  };
} 