{ inputs, globals, ... }:
let
  secrets = globals.secrets.work;
  user = secrets.username;
  system = "x86_64-linux";
in
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit secrets user; };
  modules = [
    {
      home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = "24.05";
      };
    }
    inputs.nix-index-database.hmModules.nix-index
    ../../modules/linux
  ];
}
