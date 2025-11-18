return {
  {
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      todo_states = {
        unchecked = { marker = "○" },
        checked = { marker = "●" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>T.",
        function()
          Snacks.scratch.open({
            ft = "markdown",
            file = vim.fn.getcwd() .. "/todo.md",
          })
        end,
        desc = "Toggle Scratch Todo",
      },
    },
  },
}
