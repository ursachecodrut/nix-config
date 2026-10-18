{
  # Steam launch option: mangohud %command%
  programs.mangohud = {
    enable = true;
    settings = {
      # Layout
      position = "top-left";
      horizontal = false;
      font_size = 20;
      background_alpha = 0.4;
      round_corners = 8;
      toggle_hud = "Shift_R+F12";

      # CPU / GPU
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_power = true;
      vram = true;
      ram = true;

      # Frame timing
      fps = true;
      frametime = true;
      frame_timing = true;
      fps_limit = "0"; # 0 = unlimited; e.g. "144,60" to toggle between limits
      toggle_fps_limit = "Shift_L+F1";

      # Misc
      gamemode = true;
      vulkan_driver = true;
      resolution = true;
    };
  };
}
