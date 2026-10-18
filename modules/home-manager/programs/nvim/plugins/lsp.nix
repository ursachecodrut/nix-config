{
  lib,
  pkgs,
  hostname,
  userConfig,
  ...
}:

let
  flake = "(builtins.getFlake (toString ~/nix-config))";
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in

{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            diagnostics = {
              globals = [ "vim" ];
            };
            telemetry = {
              enable = false;
            };
          };
        };

        nixd = {
          enable = true;
          settings = {
            options = {
              ${if isDarwin then "darwin" else "nixos"}.expr =
                "${flake}.${if isDarwin then "darwinConfigurations" else "nixosConfigurations"}.\"${hostname}\".options";
              home_manager.expr = "${flake}.homeConfigurations.\"${userConfig.name}@${hostname}\".options";
            };
            nixpkgs = {
              expr = "import ${flake}.inputs.nixpkgs { }";
            };
            formatting = {
              command = [ "${lib.getExe pkgs.nixfmt}" ];
            };
          };
        };

        elixirls = {
          enable = true;
          # Optional: Point to a specific package if you need a different version
          # package = pkgs.elixir-ls;

          settings = {
            dialyzerEnabled = true;
            fetchDeps = false;
          };
        };

        ts_ls = {
          enable = true;
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
        };

        biome = {
          enable = true;
        };

        marksman = {
          enable = true;
        };

        tailwindcss = {
          enable = true;
          filetypes = [
            "html"
            "css"
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "elixir"
            "heex"
          ];
          settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex";
                heex = "html-eex";
              };
              experimental = {
                classRegex = [
                  "class[:]\\s*\"([^\"]*)\""
                ];
              };
            };
          };
        };

        ruff.enable = true;
        ty.enable = true;
        eslint.enable = true;
        tinymist.enable = true;
        clangd.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
          settings = {
            cargo.buildScripts.enable = true;
            procMacro.enable = true;
          };
        };
        beancount = {
          enable = true;
          extraOptions = {
            cmd = [
              "beancount-language-server"
              "--stdio"
            ];
            root_markers = [
              "main.bean"
              ".git"
            ];
            init_options = {
              journal_file = "main.bean";
              diagnostic_flags = [ "!" ];
              completion.fuzzy_match_accounts = true;
            };
          };
          settings.beancount.formatting = {
            prefix_width = 30;
            currency_column = 60;
            number_currency_spacing = 1;
          };
        };

        emmet_ls = {
          enable = true;
          filetypes = [
            "html"
            "css"
            "heex"
            "elixir"
          ];
        };
      };

      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "gt" = "type_definition";
          "gi" = "implementation";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
        diagnostic = {
          "<leader>k" = "open_float";
          "]d" = "goto_next";
          "[d" = "goto_prev";
        };
        extra = [
          {
            key = "<leader>ds";
            action.__raw = "function() vim.diagnostic.open_float({ scope = \"line\" }) end";
          }
          {
            key = "<leader>dv";
            action.__raw = "function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end";
          }
          {
            key = "<leader>lx";
            action = "<CMD>LspStop<Enter>";
          }
          {
            key = "<leader>ls";
            action = "<CMD>LspStart<Enter>";
          }
          {
            key = "<leader>lr";
            action = "<CMD>LspRestart<Enter>";
          }
        ];
      };
    };
  };
}
