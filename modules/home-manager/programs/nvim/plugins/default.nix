{ ... }:

{
  imports = [
    ./colorscheme.nix
    ./treesitter.nix
    ./lualine.nix
    ./lsp.nix
    ./blink.nix
    ./fzf-lua.nix
    # ./oil.nix
    ./nvim-tree.nix
  ];

  programs.nixvim = {
    plugins = {
      indent-blankline.enable = true;
      copilot-vim.enable = true;
      tmux-navigator.enable = true;
    };
  };
}
