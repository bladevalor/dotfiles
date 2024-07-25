local keymap = vim.keymap

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys in normal mode
keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- convienient command for <esc>
keymap.set('i', 'jk', '<ESC>')
keymap.set('t', 'jk', '<C-\\><C-n>', {desc = "Escape terminal mode to normal mode"})

-- clear search highlights
keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- switch windows
keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })

-- split windows
keymap.set('n', '<leader>sv', "<C-w>v") -- split window vertically
keymap.set('n', '<leader>se', '<C-w>=') -- make split windows equal width
keymap.set('n', '<leader>sx', ':close<CR>') -- close current split window
keymap.set('n', '<leader>sm', ':MaximizerToggle<CR>') -- vim maximizer

-- tab mgt
keymap.set('n', '<leader>to', ':tabnew<CR>') -- open new tab
keymap.set('n', '<leader>tx', ':tabclose<CR>') -- close current tab
keymap.set('n', '<leader>tn', ':tabn<CR>') -- go to next tab
keymap.set('n', '<leader>tp', ':tabp<CR>') -- goto next tab

-- nvim-tree
keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "telescope color schemes" })

-- conform
keymap.set("n", "<leader>fm", function()
   require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- Comment
keymap.set("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
keymap.set("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- toggle the most recent buffers
keymap.set("n", "<leader><leader>", "<C-^>")






