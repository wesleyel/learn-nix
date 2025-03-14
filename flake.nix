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
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let 
    inherit (builtins) head elemAt attrNames readDir; 
    inherit (nixpkgs.lib) importTOML flatten genAttrs splitString;

    # Supported Systems
    systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

    sharedModules = [ ./lib ];

    # Shhhhh
    # Semi-private files encrypted with git-crypt. Profiles relying on these files will fail if not decrypted first.
    # Read all the files, and mush them into a top level hush attribute set; Expects TOML format
    secrets = let dir = ./secrets; temp = {}; in
      head (map (x: temp // (importTOML "${dir}/${x}")) (attrNames (readDir dir)));

    # Prefix every string in a given LIST with a given FLAG, seperated by dots
    genProfileNames = list: flag: (map (x: "${flag}.${x}") list);

    # Use the given FUNC to generate an attribute set, whose attribute name's are a profile,
    # based upon the names of the subdirs found in the given DIR, and the available systems.
    applyProfiles = dir: func: (genAttrs
        (flatten (map (genProfileNames systems)
          (attrNames (readDir dir)))) func);

    # Generate SYSTEM, PROFILENAME, and PKGS, based on a given profile.
    #
    # EX: genParams "justinlime@jenovo.x86_64-linux" => { profileName = "justinlime@jenovo"; system = "x86_64-linux"; pkgs = nixpkgs.legacyPackages.x86-64_linux; }
    genParams = profile: let split = splitString "." profile; in rec {
      profileName = elemAt split 0;            
      system =  elemAt split 1;         
      pkgs = nixpkgs.legacyPackages.${system};
    };

    # Generate a buildable configuration for every possible combination
    # of system architecture, and profile.
    #
    # The attribute names will be in the format of
    #
    # ${subdirname}.${system} 
    allHomeConfigurations = applyProfiles ./users
      (profile:
        with (genParams profile);
        # Bootstrap a home-manager profile using something like:
        # nix run --extra-experimental-features 'nix-command flakes' github:nix-community/home-manager -- switch --flake path:/data/codes/learn-nix#personal.x86_64-linux --experimental-features 'nix-command flakes'
        #
        # After first rebuild and subsequent shell reload, you can rebuild with the "home-switch" alias instead
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit profile secrets inputs; };
          modules = [
            ./modules/users
            ./users/${profileName}
          ] ++ sharedModules;
        });
    in
    {
      homeConfigurations = allHomeConfigurations; 
      homeManagerModules.default = { imports = [ ./modules/users ]; };
    }; 
}