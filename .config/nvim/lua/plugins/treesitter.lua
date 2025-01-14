return {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   config = function()
      require("nvim-treesitter.configs").setup {
         ensure_installed = {
            "c", "cpp", "rust",

            "lua", "luadoc", "vim", "vimdoc",

            "javascript", "html", "css", "markdown",

            "fish", "python", "elixir",
         },
         sync_install = false, -- install multiple parsers at once
         auto_install = true,
         highlight = {
            enable = true,
            disable = { "latex", },
         },
         indent = {
            enable = true
         },
      }
   end
}
