return {
   "sainnhe/sonokai",
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		config = function()
			require("nightfox").setup({
				options = {
					colorblind = {
						enable = true,
						severity = {
							protan = 0.3, -- red
							deutan = 0.6, -- green
							-- tritan = 0.6,     -- blue
						},
					},
				},
			})
		end,
	},
	{
		"ribru17/bamboo.nvim",
		lazy = false,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		config = function()
			require("cyberdream").setup({
				options = {
					theme = {
						variant = "auto",
					},
				},
			})
		end,
	},
}
