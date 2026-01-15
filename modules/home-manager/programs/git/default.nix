{ userConfig, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = userConfig.email;
        name = userConfig.fullName;
      };
      pull.rebase = "true";
      init.defaultBranch = "main";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      keep-plus-minus-markers = true;
      light = false;
      line-numbers = true;
      navigate = true;
      width = 280;
    };
  };

  # catppuccin.delta.enable = true;
}
