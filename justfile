default: switch
flake_dir := if path_exists(justfile_directory() / "flake.nix") == "true" { justfile_directory() } else { env_var("HOME") + "/.dotfiles" }

[linux]
switch flags="": git-add
    nix run -- home-manager switch --flake {{flake_dir}}#home-work --impure {{flags}}

[macos]
switch flags="": git-add
    nix run -- nix-darwin switch --flake {{flake_dir}}#home-darwin {{flags}}

trace: (switch "--show-trace")
    
home: git-add
    nix run -- home-manager switch --flake {{flake_dir}}#$(hostname)

update: git-add
    nix flake update

git-add:
    git -C {{flake_dir}} add --intent-to-add --all