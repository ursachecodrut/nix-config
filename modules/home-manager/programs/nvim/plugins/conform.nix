{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        svelte = [ "prettier" ];
        css = [ "prettier" ];
        html = [ "prettier" ];
        heex = [ "prettier" ];
        json = [ "prettier" ];
        yaml = [ "prettier" ];
        toml = [ "taplo" ];
        markdown = [ "prettier" ];
        graphql = [ "prettier" ];
        python = [ "ruff" ];
      };
    };

    extraPackages = with pkgs; [
      prettier
      taplo
      ruff
    ];

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>mf";
        action.__raw = ''
          function()
            require("conform").format({ lsp_format = "fallback", async = false, timeout_ms = 500 })
          end
        '';
        options.desc = "Format file or range (in visual mode)";
      }
    ];
  };
}
