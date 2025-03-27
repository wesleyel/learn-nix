{ config, ... }: {
  programs.atuin = {
    enable = true;
    settings = {
      style = "compact";
      inline_height = 15;
      enter_accept = true;
    };
  };
}
