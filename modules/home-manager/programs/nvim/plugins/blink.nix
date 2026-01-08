{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;

      settings = {
        appearance = {
          nerd_font_variant = "mono";
          use_nvim_cmp_as_default = true;
        };

        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
          };
          list = {
            selection = {
              auto_insert = true;
            };
          };
        };

        keymap = {
          preset = "default";
        };

        signature = {
          enabled = true;
        };

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };
    };
  };
}
