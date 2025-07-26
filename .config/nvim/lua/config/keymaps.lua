-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local keymap = vim.keymap

-- convienient command for <esc>
keymap.set("i", "jk", "<ESC>", { desc = "Escape insert mode" })
keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Escape terminal mode to normal mode" })
