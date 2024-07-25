return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependancies = {
		"nvim-lua/plenary.vim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		defaults = {
			file_ignore_patterns = {
				"target/",
			},
		},
	},
}
