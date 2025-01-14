local blink = {
   "saghen/blink.cmp",
   enable = false,
   opts   = {
      keymap = {
         preset = "default",
         ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
         ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
         ["<CR>"] = { "accept", "fallback" },
         ["<Esc>"] = { "hide", "fallback" },
         ["<PageUp>"] = { "scroll_documation_up", "fallback" },
         ["<PageDown>"] = { "scroll_documation_down", "fallback" },
      },
      completion = {
         list = { selection = "manual" },
         menu = { border = 'single' },
         documentation = {
            window = { border = 'single' }
         },
      },
      signature = {
         enabled = true,
         window = { border = 'single' }
      },
   }
}

return {}
