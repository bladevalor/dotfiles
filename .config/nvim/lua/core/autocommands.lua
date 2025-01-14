local autocmd = vim.api.nvim_create_autocmd

-- vim.highlight.on_yank()
autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying) text",
   callback = function()
      vim.highlight.on_yank()
   end,
})

-- autocmd("QuickFixCmdPost", {
--    desc = "Open quickfix window if there are errors",
--    pattern = "*",
--    callback = function()
--       if vim.v.errors > 0 then
--          vim.cmd("copen")
--       end
--    end,
-- })
