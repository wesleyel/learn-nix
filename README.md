# Home manager Configuration

This repository is a collection of my home manager configurations for different machines.

Thanks to [justinlime](https://github.com/justinlime/dotfiles). I stole a lot of the structure from his repository.

## Install

### Install nix (If you don't have it)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

### Set up home-manager

```bash
git clone https://github.com/wesleyel/learn-nix.git ~/dotfiles

# unlock the secrets
base64 -d <<< "SECRETS_BASE64" > /tmp/secret-key
nix run nixpkgs#git-crypt -- unlock /tmp/secret-key

# Switch to work profile
nix run --extra-experimental-features 'nix-command flakes' github:nix-community/home-manager -- switch --flake  ~/dotfiles#work.x86_64-linux -b backup --experimental-features 'nix-command flakes'

# Switch to personal profile
nix run --extra-experimental-features 'nix-command flakes' github:nix-community/home-manager -- switch --flake  ~/dotfiles#personal.x86_64-linux -b backup --experimental-features 'nix-command flakes'

# After first rebuild and subsequent shell reload, you can rebuild with the "home-switch" alias instead
home-manager switch
```

### Setup zsh

```bash
# set default shell to zsh
echo ~/.nix-profile/bin/zsh | sudo tee -a /etc/shells
usermod -s ~/.nix-profile/bin/zsh $USER
```
