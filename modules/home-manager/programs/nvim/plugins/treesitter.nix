{ pkgs, ... }:

let
  parsers = [
    "arduino"
    "bash"
    "beancount"
    "c"
    "cmake"
    "comment"
    "cpp"
    "css"
    "csv"
    "diff"
    "dockerfile"
    "editorconfig"
    "eex"
    "elixir"
    "elm"
    "erlang"
    "git_config"
    "git_rebase"
    "gitcommit"
    "gitignore"
    "gleam"
    "go"
    "graphql"
    "haskell"
    "heex"
    "helm"
    "hjson"
    "html"
    "http"
    "java"
    "javascript"
    "jsdoc"
    "json"
    "json5"
    "kdl"
    "liquid"
    "llvm"
    "lua"
    "make"
    "markdown"
    "markdown_inline"
    "mermaid"
    "nginx"
    "nix"
    "pkl"
    "promql"
    "python"
    "query"
    "regex"
    "ruby"
    "rust"
    "scss"
    "sql"
    "ssh_config"
    "surface"
    "terraform"
    "toml"
    "tsx"
    "typescript"
    "typst"
    "vim"
    "vimdoc"
    "xml"
    "yaml"
    "zig"
  ];
in
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
      grammarPackages = map (n: pkgs.vimPlugins.nvim-treesitter.builtGrammars.${n}) parsers;
    };
  };
}
