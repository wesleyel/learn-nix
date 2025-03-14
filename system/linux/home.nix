{
    pkgs,
    config,
    ...
}:
{
    imports = [
        ../modules/git
    ];

    home = {
        packages = with pkgs; [
            git
        ];

        sessionVariables = {
            EDITOR = "vim";
        };
    };

    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}