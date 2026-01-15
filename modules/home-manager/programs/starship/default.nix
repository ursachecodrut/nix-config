{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      format = lib.concatStrings [
        "$conda"
        "$directory"
        "$git_branch"
        # "$line_break"
        "$character"
      ];

      right_format = lib.concatStrings [
        "$cmd_duration"
        "$time"
      ];

      add_newline = false;

      directory = {
        style = "green";
        truncate_to_repo = false;
      };

      kubernetes = {
        symbol = "⎈ ";
        format = "[$symbol](bright-blue)[$context](red bold)[( \\($namespace\\))](blue) ";
        disabled = false;
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = " ";
        disabled = false;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#6272a4";
        format = "[ $time ]($style)";
      };

      cmd_duration = {
        min_time = 500;
        format = "[$duration](#6272a4) ";
      };
    };
  };

  catppuccin.starship.enable = true;
}
