return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = true,

    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/pubspec.yaml") == 1 then
          require("lazy").load({ plugins = { "flutter-tools.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,

    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },

    config = function()
      require("flutter-tools").setup({})

      local which = require("which-key")
      which.add({
        {
          "<leader>fl",
          group = "Flutter/Dart",
          icon = " ",
        },
        {
          "<leader>fll",
          "<cmd>FlutterLogToggle<cr>",
          desc = "Toggle flutter logs",
        },
      })
    end,
  },
}
