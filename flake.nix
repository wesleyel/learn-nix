{
  description = "Home Manager 配置";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
    let
      # 读取.env文件（如果存在）
      readEnvFile = path:
        let
          exists = builtins.pathExists path;
          content = if exists then builtins.readFile path else "";
          lines = if exists then builtins.filter (l: l != "" && !(builtins.match "^#.*" l != null)) 
                  (builtins.split "\n" content) else [];
          parseLine = line:
            let
              match = builtins.match "([^=]*)=(.*)" line;
            in
            if match != null then {
              name = builtins.elemAt match 0;
              value = builtins.elemAt match 1;
            } else null;
          envVars = builtins.filter (x: x != null) (map parseLine lines);
          envSet = builtins.listToAttrs (map (x: { inherit (x) name value; }) envVars);
        in envSet;
      
      # 尝试加载.env文件
      envVars = readEnvFile ./.env;
    in
    {
      homeConfigurations = {
        "work" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; inherit envVars; };
          modules = [ ./configurations/work ];
        };

        "personal" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; inherit envVars; };
          modules = [ ./configurations/personal ];
        };
      };
    };
} 