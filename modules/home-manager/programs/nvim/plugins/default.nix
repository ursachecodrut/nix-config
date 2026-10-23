{ pkgs, ... }:

{
  imports = [
    ./colorscheme.nix
    ./treesitter.nix
    ./lualine.nix
    ./lsp.nix
    ./blink.nix
    ./fzf-lua.nix
    ./nvim-tree.nix
    ./gitsigns.nix
    ./marks.nix
    ./ts-autotag.nix
    ./snippets.nix
    ./trouble.nix
    ./conform.nix
    ./nvim-ufo.nix
    ./csvview.nix
    ./image.nix
    ./neogit.nix
  ];

  programs.nixvim = {
    plugins = {
      indent-blankline.enable = true;
      nvim-surround.enable = true;
      render-markdown.enable = true;
      typst-preview.enable = true;
      tmux-navigator = {
        enable = true;
        settings.no_mappings = 1;
      };
    };

    # herdr-aware navigation mappings (from the vim-herdr-navigation plugin)
    extraConfigLua = ''
      dofile("${import ../../herdr/vim-herdr-navigation.nix { inherit pkgs; }}/editor/nvim.lua")
    '';
  };
}
