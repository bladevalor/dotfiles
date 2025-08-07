return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            exclude = { ".git", ".github", "node_modules" },
          },
          files = {
            hidden = true,
            exclude = { "node_modules" },
          },
        },
      },
    },
  },
}
