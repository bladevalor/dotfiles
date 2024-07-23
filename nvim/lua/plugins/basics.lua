return {
   "nvim-lua/plenary.nvim",       -- dependacy for telescope

   "szw/vim-maximizer",           -- maximises and restores current window

   "nvim-tree/nvim-web-devicons", -- file type icons

   {
      "nvim-lualine/lualine.nvim", -- status bar
      dependancies = { "nvim-tree/nvim-web-devicons" },
      opts = {},
   },

   {
      "lukas-reineke/indent-blankline.nvim", -- hightlights indents with a "|"
      main = "ibl",
      opts = {},
   },

   {
      "folke/todo-comments.nvim", -- takes TODO/README/FIX/... comments in context
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      opts = { signs = false }
   },

   {
      dir = "~/.local/share/nvim/kanata-vim",
      name = "kanata.nvim",
   },

   {
      "stevearc/conform.nvim",
      lazy = false,
      opts = {
         formatters_by_ft = {
            lua = { "stylua" },
         },
      },
   },
}
