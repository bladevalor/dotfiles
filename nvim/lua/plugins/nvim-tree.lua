return { 
   "nvim-tree/nvim-tree.lua", --file explorer
   version ='*',
   lazy = false,
   dependacies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      vim.g.loaded = 1
      vim.g.loaded_netrwPluging = 1
      require("nvim-tree").setup {}
   end,
}
