let
  map = key: action: desc: {
    mode = "n";
    inherit key action;
    options.desc = desc;
  };
in
{
  programs.nixvim = {
    plugins = {
      diffview.enable = true;
      neogit = {
        enable = true;
        settings = {
          integrations = {
            diffview = true;
            fzf_lua = true;
          };
          graph_style = "unicode";
        };
      };
    };

    keymaps = [
      (map "<leader>gg" "<cmd>Neogit<cr>" "neogit")
      (map "<leader>gC" "<cmd>Neogit commit<cr>" "neogit Commit")
      (map "<leader>gp" "<cmd>Neogit push<cr>" "neogit Push")
      (map "<leader>gP" "<cmd>Neogit pull<cr>" "neogit Pull")
      (map "<leader>gd" "<cmd>DiffviewOpen<cr>" "Diffview Open")
      (map "<leader>gD" "<cmd>DiffviewOpen HEAD~1<cr>" "Diffview Last Commit")
      (map "<leader>gx" "<cmd>DiffviewClose<cr>" "Diffview Close")
      (map "<leader>gH" "<cmd>DiffviewFileHistory %<cr>" "Diffview File History")
    ];
  };
}
