local autocmd = vim.api.nvim_create_autocmd
local hostname = vim.fn.system("hostname"):gsub("\n$", "")

-- vim.highlight.on_yank()
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

if hostname == "kara" then
	vim.cmd.colorscheme("bamboo")
else
   vim.cmd.colorscheme("sonokai")
end
