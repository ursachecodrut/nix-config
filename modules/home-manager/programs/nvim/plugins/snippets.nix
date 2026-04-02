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

    extraConfigLua = ''
      -- HEEx/Phoenix snippets
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local c = ls.choice_node
      local rep = require("luasnip.extras").rep

      ls.add_snippets("heex", {
        -- {expression} - Elixir expression
        s("ee", { t("{"), i(1), t("}") }),
        -- {@variable} - attribute interpolation
        s("ea", { t("{@"), i(1), t("}") }),
        -- <%= expression %> - EEx output
        s("eex", { t("<%= "), i(1), t(" %>") }),
        -- <% code %> - EEx code block
        s("ex", { t("<% "), i(1), t(" %>") }),
        -- :if={condition}
        s("eif", { t(":if={"), i(1), t("}") }),
        -- :for={item <- items}
        s("efor", { t(":for={"), i(1), t(" <- "), i(2), t("}") }),
        -- <.component /> - function component
        s("ec", { t("<."), i(1), t(" />") }),
        -- <.component>content</.component>
        s("ecb", { t("<."), i(1), t(">"), i(2), t("</."), i(3), t(">") }),
        -- <.component>content</.component> with same name
        s("fcc", { t("<."), i(1, "component"), t(">"), i(2), t("</."), rep(1), t(">") }),
        -- <:slot>content</:slot>
        s("sl", { t("<:"), i(1, "slot"), t(">"), i(2), t("</:"), rep(1), t(">") }),
        -- Phoenix.Component.link
        s("elink", { t("<.link navigate={~p\""), i(1), t("\"}>"), i(2), t("</.link>") }),
        -- form component
        s("eform", { t("<.form for={"), i(1, "@form"), t("} phx-submit=\""), i(2), t("\">"), i(3), t("</.form>") }),
        -- input component
        s("einput", { t("<.input field={"), i(1, "@form[:field]"), t("} type=\""), i(2, "text"), t("\" label=\""), i(3), t("\" />") }),
        -- button component
        s("ebtn", { t("<.button phx-click=\""), i(1), t("\">"), i(2), t("</.button>") }),
        -- phx-click
        s("pc", { t("phx-click=\""), i(1), t("\"") }),
        -- phx-change
        s("pch", { t("phx-change=\""), i(1), t("\"") }),
        -- phx-submit
        s("ps", { t("phx-submit=\""), i(1), t("\"") }),
        -- phx-value
        s("pv", { t("phx-value-"), i(1), t("={"), i(2), t("}") }),
      })

      -- Also add to elixir filetype for embedded heex in ~H sigils
      ls.add_snippets("elixir", {
        -- IO.inspect snippets
        s("ii", { t("IO.inspect("), i(1), t(")") }),
        s("iil", { t("IO.inspect("), i(1), t(", label: \""), i(2), t("\")") }),
        s("iip", { t("|> IO.inspect()") }),
        s("iipl", { t("|> IO.inspect(label: \""), i(1), t("\")") }),
        s("dbg", { t("dbg("), i(1), t(")") }),
        s("dbgp", { t("|> dbg()") }),
        -- ~H sigil
        s("heex", { t("~H\"\"\""), t({"", ""}), i(1), t({"", "\"\"\"" }) }),
        -- All HEEx snippets duplicated for elixir files
        s("ee", { t("{"), i(1), t("}") }),
        s("ea", { t("{@"), i(1), t("}") }),
        s("eex", { t("<%= "), i(1), t(" %>") }),
        s("ex", { t("<% "), i(1), t(" %>") }),
        s("eif", { t(":if={"), i(1), t("}") }),
        s("efor", { t(":for={"), i(1), t(" <- "), i(2), t("}") }),
        s("ec", { t("<."), i(1), t(" />") }),
        s("ecb", { t("<."), i(1), t(">"), i(2), t("</."), i(3), t(">") }),
        -- <.component>content</.component> with same name
        s("fcc", { t("<."), i(1, "component"), t(">"), i(2), t("</."), rep(1), t(">") }),
        -- <:slot>content</:slot>
        s("sl", { t("<:"), i(1, "slot"), t(">"), i(2), t("</:"), rep(1), t(">") }),
        s("elink", { t("<.link navigate={~p\""), i(1), t("\"}>"), i(2), t("</.link>") }),
        s("eform", { t("<.form for={"), i(1, "@form"), t("} phx-submit=\""), i(2), t("\">"), i(3), t("</.form>") }),
        s("einput", { t("<.input field={"), i(1, "@form[:field]"), t("} type=\""), i(2, "text"), t("\" label=\""), i(3), t("\" />") }),
        s("ebtn", { t("<.button phx-click=\""), i(1), t("\">"), i(2), t("</.button>") }),
        s("pc", { t("phx-click=\""), i(1), t("\"") }),
        s("pch", { t("phx-change=\""), i(1), t("\"") }),
        s("ps", { t("phx-submit=\""), i(1), t("\"") }),
        s("pv", { t("phx-value-"), i(1), t("={"), i(2), t("}") }),
      })
    '';
  };
}
