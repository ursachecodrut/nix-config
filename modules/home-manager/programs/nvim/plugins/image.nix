{
  programs.nixvim.plugins.image = {
    enable = true;
    settings = {
      backend = "kitty";
      processor = "magick_cli";
      max_height_window_percentage = 50;
      hijack_file_patterns = [
        "*.png"
        "*.jpg"
        "*.jpeg"
        "*.gif"
        "*.webp"
        "*.avif"
      ];
      integrations = {
        markdown = {
          enabled = true;
          clear_in_insert_mode = false;
          download_remote_images = true;
          only_render_image_at_cursor = false;
          only_render_image_at_cursor_mode = "popup";
          floating_windows = false;
          filetypes = [
            "markdown"
            "vimwiki"
          ];
        };
        typst.enabled = false;
        html.enabled = false;
        css.enabled = false;
      };
    };
  };
}
