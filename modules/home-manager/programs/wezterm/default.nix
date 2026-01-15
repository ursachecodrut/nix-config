{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = false;
    
    extraConfig = ''
    local wezterm = require("wezterm")

    local config = wezterm.config_builder()
    
    -- Font
    config.font = wezterm.font("JetBrains Mono")
    config.font_size = 14.0
    
    -- Color scheme
    config.color_scheme = "Catppuccin Mocha"
    
    -- Disable bell
    config.audible_bell = "Disabled"
    
    config.colors = {
    	cursor_bg = "white",
    	cursor_border = "white",
    }
    
    -- Appearance
    config.window_decorations = "RESIZE"
    
    -- Misscelaneous
    config.max_fps = 60
    config.prefer_egl = true
    
    return config
    '';
  };
}
