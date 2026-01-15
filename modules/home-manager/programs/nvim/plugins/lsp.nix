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
              command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
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
      };

      keymaps = {
        silent = true;
        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "K" = "hover";
          "gi" = "implementation";
          "gr" = "references";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };
    };
  };
}
