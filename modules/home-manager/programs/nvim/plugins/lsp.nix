{ lib, pkgs, ... }:

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
              nixos.expr = "(builtins.getFlake (toString ~/nixdots)).nixosConfigurations";

              home_manager.expr = "(builtins.getFlake (toString ~/nixdots)).homeConfigurations";
            };
            nixpkgs = {
              expr = "import <nixpkgs> {}";
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
