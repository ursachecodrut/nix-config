{ pkgs, ... }:
{
  home.packages = [ pkgs.nodejs ];

  programs.claude-code = {
    enable = true;

    mutableSettings = true;

    settings = {
      model = "opus";
      theme = "dark-ansi";
      statusLine = {
        type = "command";
        command = "${pkgs.nodejs}/bin/npx -y ccstatusline@latest";
        padding = 0;
      };
    };
  };
}
