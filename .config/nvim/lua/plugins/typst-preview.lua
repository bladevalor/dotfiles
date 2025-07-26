return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {
      dependencies_bin = {
        ["tinymist"] = "tinymist",
      },
    }, -- lazy.nvim will implicitly calls `setup {}`
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        tinymist = function()
          require("tinymist").setup({
            settings = { formatterMode = "typstyle", exportPdf = "onType", semanticTockens = "disable" },
          })
        end,
      },
    },
  },
}
