{
  programs.nixvim = {
    plugins = {
      blink-cmp = {
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

          snippets = {
            preset = "luasnip";
          };

          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "copilot"
            ];

            providers = {
              copilot = {
                name = "copilot";
                module = "blink-copilot";
                score_offset = 100;
                async = true;

                opts = {
                  max_completions = 3;
                  max_attempts = 4;
                  kind = "Copilot";
                  debounce = 750;
                  auto_refresh = {
                    backward = true;
                    forward = true;
                  };
                };
              };

              lsp = {
                name = "LSP";
                module = "blink.cmp.sources.lsp";

                score_offset = 0;

                override = {
                  emmet_ls = {
                    score_offset = -100;
                  };
                };
              };
            };
          };
        };
      };

      blink-copilot.enable = true;
    };
  };
}
