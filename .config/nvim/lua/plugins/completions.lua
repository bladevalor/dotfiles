return {
   "hrsh7th/nvim-cmp",
   version = false,
   event = "InsertEnter",
   dependencies = {
      {
         -- snippet plugin
         "L3MON4D3/LuaSnip",
         dependencies = "rafamadriz/friendly-snippets",
         opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI"
         },
         config = function(_, opts)
            require("luasnip").config.set_config(opts)
            require("luasnip.loaders.from_vscode").lazy_load()
         end,
      },

      -- cmp sources plugins
      {
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "micangl/cmp-vimtex"
      },

   },

   opts = function()
      return require "plugins.utils.cmpconfig"
   end,

   -- config = function()
   --    local cmp = require "cmp"
   --    cmp.setup.filetype("tex", {
   --       sources = {
   --          { name = 'vimtex' },
   --          { name = 'buffer', keywork_length = 4 },
   --       },
   --    })
   -- end
   --
}
