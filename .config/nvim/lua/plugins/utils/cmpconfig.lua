local cmp = require "cmp"
local luasnip = require "luasnip"

local options = {
   completion = { completeopt = "menu,menuone,noselect,noinsert" },

   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },

   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },

   sources = {
      { name = "vimtex" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer",  keyword_length = 4 },
      { name = "nvim_lua" },
      { name = "path" },
   },

   formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
         vim_item.menu = ({
            vimtex = "[vTex]",
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            path = "[Path]",
         })[entry.source.name]
         return vim_item
      end
   },

   mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),

      ["<CR>"] = cmp.mapping(function(fallback)
         if cmp.visible() and cmp.get_active_entry() then
            if luasnip.expandable() then
               luasnip.expand()
            else
               cmp.confirm({
                  select = true,
               })
            end
            -- if nothing is selected, <CR> does nothing(Just makes a new line)
         else
            fallback()
         end
      end),

      ["<Tab>"] = cmp.mapping(function(fallback)
         if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<C-n>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<C-p>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   },

}
return options
