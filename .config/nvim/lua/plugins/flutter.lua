return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    keys = {
      {
        "<leader>tl",
        "<cmd>FlutterLogToggle<cr>",
        desc = "Toggle flutter logs",
      },
    },
  },
}
