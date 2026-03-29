return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- vscode-like snippets
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      -- lazy-load vscode-like snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/custom_snippets" } })

      -- extend "javascript" snippets to "typescript"
      require("luasnip").filetype_extend("typescript", { "javascript" })
    end,
  },
}
