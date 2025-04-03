{ secrets, pkgs, ... }:
{
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    extra-experimental-features = nix-command flakes
    experimental-features = nix-command flakes
    access-tokens = github.com=${secrets.github_token}
  '';
}