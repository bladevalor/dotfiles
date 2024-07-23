return {
   "lewis6991/gitsigns.nvim", -- Adds git related signs to the gutter
   opts = {
      signs = {
         add = { text = "│" },
         change = { text = "│" },
         delete = { text = "󰍵" },
         topdelete = { text = "‾" },
         changedelete = { text = "~" },
         untracked = { text = "│" },
      },
   },
}
