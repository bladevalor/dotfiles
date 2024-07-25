return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
         h = {"clang-format"},
         c = {"clang-format"},
         cpp = {"clang-format"},
		},
	},
}
