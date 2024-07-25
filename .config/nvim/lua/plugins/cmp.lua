return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ -- completion sources for nvim-cmp
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		{
			"L3MON4D3/LuaSnip", -- Snippet Engine
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" }, -- VS Code like syntax library
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				-- My personal snippets
				require("luasnip.loaders.from_lua").load({
					paths = {
						"~/.config/nvim/MySnips/",
					},
				})
			end,
		},
	},

	config = function()
		local luasnip = require("luasnip")
		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})
		luasnip.config.setup({})

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				-- specify a snippet engine, LuaSnip in this case
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			completion = {
				completeopt = "menu,menuone,noinsert",
				keyword_length = 1,
				keyword_pattern = ".*",
			},

			sources = {
				{ name = "nvim_lsp", keyword_length = 1 },
				{ name = "luasnip", keyword_length = 1 },
				{ name = "buffer", keyword_length = 5 },
				{ name = "path" },
			},

			-- For why these mappings were chosen,
			-- you will need to read `:help ins-completion`
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),

				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}
