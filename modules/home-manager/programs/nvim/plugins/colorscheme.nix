{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.auto-dark-mode-nvim ];
    extraConfigLua = ''
      require("auto-dark-mode").setup()
    '';

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "auto";
        background = {
          light = "latte";
          dark = "mocha";
        };

        integrations = {
          blink_cmp = true;
          fzf = true;
          lsp_trouble = true;
          native_lsp = {
            enabled = true;
            underlines = {
              errors = [ "undercurl" ];
              hints = [ "undercurl" ];
              warnings = [ "undercurl" ];
              information = [ "undercurl" ];
            };
          };
          oil = true;
          treesitter = true;
        };
      };
    };
  };
}
