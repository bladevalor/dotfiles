return {
  {
    "wstucco/c3.nvim",
    ft = "c3",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        c3_lsp = {
          -- filetypes = { "c3", "c3i" },
          -- root_markers = { "c3c.toml", ".git" },
        },
      },
    },
  },
}
