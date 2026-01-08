{...}:

{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "mocha"; 
        
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