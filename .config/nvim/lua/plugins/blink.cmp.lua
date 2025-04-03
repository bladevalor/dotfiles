local blink = {
   "saghen/blink.cmp",
   version = "1.*",

   dependencies = { "rafamadriz/friendly-snippets" },

   opts   = {
      completion = {
         list = {
            selection = {
               preselect = false,
               auto_insert = false,
            }
         },
         documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
         }
      },
      signature = {
         enabled = true,
      },
   },

   config = function ()
      require("blink.cmp").setup()
   end
}

return blink
