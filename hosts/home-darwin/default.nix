{ inputs, globals, ... }:
let
  secrets = globals.secrets.personal;
  user = secrets.username;
in
inputs.nix-darwin.lib.darwinSystem rec {
  system = "aarch64-darwin";
  specialArgs = { };

  modules = [
    secrets
    user
    inputs.mac-app-util.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    ../../modules/macos
    {
      home-manager.users.${user}.imports = [
        inputs.nix-index-database.hmModules.nix-index
      ];
    }
  ];
}
