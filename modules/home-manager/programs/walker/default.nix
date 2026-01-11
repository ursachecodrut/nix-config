{ inputs, ... }:
{
  imports = [ inputs.walker.homeManagerModules.default ];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      providers = {
        default = [
          "desktopapplications"
          "menus"
        ];
        prefixes = [
          {
            prefix = "!";
            provider = "menus:power";
          }
          {
            prefix = "*";
            provider = "menus:capture";
          }
          {
            prefix = "-";
            provider = "todo";
          }
        ];
      };
    };
  };

  xdg.configFile."elephant/menus/power.toml".text = ''
    name = "power"
    name_pretty = "Power Menu"
    icon = "system-shutdown"

    [[entries]]
    text = "Power Off"
    keywords = ["shutdown", "poweroff", "power off"]
    actions = { "poweroff" = "systemctl poweroff" }

    [[entries]]
    text = "Restart"
    keywords = ["reboot", "restart"]
    actions = { "restart" = "systemctl reboot" }

    [[entries]]
    text = "Suspend"
    keywords = ["suspend", "sleep"]
    actions = { "suspend" = "systemctl suspend" }

    [[entries]]
    text = "Lock"
    keywords = ["lock", "lockscreen"]
    actions = { "lock" = "hyprlock" }

    [[entries]]
    text = "Logout"
    keywords = ["logout", "exit", "quit"]
    actions = { "logout" = "hyprctl dispatch exit" }
  '';

  xdg.configFile."elephant/menus/capture.toml".text = ''
    name = "capture"
    name_pretty = "Screen Capture Menu"
    icon = "camera"

    [[entries]]
    text = "Copy to Clipboard"
    keywords = ["screenshot", "screen", "capture", "clipboard"]
    actions = { "copy_to_clipboard" = "$HOME/.local/bin/screenshot-shot.sh copy" }

    [[entries]]
    text = "Save to File"
    keywords = ["screenshot", "screen", "capture", "file"]
    actions = { "save_to_file" = "$HOME/.local/bin/screenshot-shot.sh save" }

    [[entries]]
    text = "OCR Text"
    keywords = ["screenshot", "screen", "capture", "ocr", "text"]
    actions = { "ocr_text" = "$HOME/.local/bin/screenshot-shot.sh ocr" }

    [[entries]]
    text = "Record Video"
    keywords = ["screenshot", "screen", "capture", "record", "area"]
    actions = { "record_video" = "$HOME/.local/bin/screen-record.sh" }
  '';
}
