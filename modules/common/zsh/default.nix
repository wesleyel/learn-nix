{ pkgs, secrets, user, ... }: {
  programs.zsh.enable = true;

  home.file = {
    ".p10k-ascii-8color.zsh".source = ./.p10k.zsh;
    ".p10k.zsh".source = ./.p10k.zsh;
    ".zprofile".source = ./.zprofile;
    ".zsh-aliases".source = ./.zsh-aliases;
    ".zshenv".source = ./.zshenv;
    ".zshrc".source = ./.zshrc;
    ".zsh-extra".text = ''
      JQ_ZSH_PLUGIN_EXPAND_ALIASES=0
      z4h source -- ${pkgs.jq-zsh-plugin}/share/jq-zsh-plugin/jq.plugin.zsh
      z4h source -- /etc/profile.d/nix.sh

      # proxy
      export http_proxy="${secrets.http_proxy}"
      export https_proxy="${secrets.http_proxy}"
      export HTTP_PROXY="${secrets.http_proxy}"
      export HTTPS_PROXY="${secrets.http_proxy}"
      export no_proxy="${secrets.no_proxy}"
      export NO_PROXY="${secrets.no_proxy}"
    '';
  };
}
