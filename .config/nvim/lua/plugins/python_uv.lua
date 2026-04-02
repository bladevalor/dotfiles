return {
  {
    "benomahony/uv.nvim",
    lazy = true,

    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/pyproject.toml") == 1 then
          require("lazy").load({ plugins = { "uv.nvim" } })
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

    opts = {
      picker_integration = true,
      keymaps = false,
    },
  },
}
