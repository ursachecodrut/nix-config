{
  programs.nixvim = {
    plugins = {
      friendly-snippets.enable = true;
      luasnip = {
        enable = true;
        settings = {
          history = true;
          region_check_events = "InsertEnter";
          delete_check_events = "TextChanged";
        };
      };
    };

    extraConfigLua = builtins.readFile ../snippets.lua;
  };
}
