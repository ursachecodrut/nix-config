{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        highlight = {
          enable = true;
          use_languagetree = true;
        };
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        gitignore
        json
        markdown
        yaml
        nix
        bash
        vim
        dockerfile
        jsdoc
        typescript
        javascript
        python
        elixir
        erlang
        graphql
      ];
    };
  };
}
