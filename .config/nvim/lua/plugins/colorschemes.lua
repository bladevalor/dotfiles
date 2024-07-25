return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		config = function()
			require("nightfox").setup({
				options = {
					colorblind = {
						enable = true,
						severity = {
							protan = 0.3,     -- red
							deutan = 0.6,     -- green
							-- tritan = 0.6,     -- blue
						},
					},
				},
			})

			-- vim.cmd.colorscheme("dayfox")
		end,
	},
	{
		"ribru17/bamboo.nvim",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("bamboo")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		opts = {
			theme = {
				variant = "auto",
			},
		},
		config = function()
			-- vim.cmd.colorscheme("cyberdream")
		end,
	},
}
