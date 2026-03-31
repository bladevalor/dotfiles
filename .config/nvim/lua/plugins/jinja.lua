return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "htmldjango" } },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "djlint", -- Jinja templates/files linter
        "jinja-lsp", -- jinja templates/files lsp
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {
          filetypes = { "htmldjango", "python", "jinja", "rust" },
          capabilites = require("blink.cmp").get_lsp_capabilities(),
          root_markers = {
            { "pyproject.toml", "Cargo.toml" },
            "manage.py",
            "requirements.txt",
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        jinja = { "djlint" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        htmldjango = { "djlint" },
        jinja = { "djlint" },
      },
    },
  },
}
