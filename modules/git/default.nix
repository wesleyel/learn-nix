{
    pkgs,
    config,
    ...
}:
{
    programs.git = {
        enable = true;
        userName = "wesley";
        userEmail = "wesley@example.com";
        extraConfig = {
            core = {
                editor = "vim";
            };
            push.autoSetupRemote = true;
        };
    };
}