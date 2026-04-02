return {
  {
    "Civitasv/cmake-tools.nvim",

    opts = {
      cmake_build_directory = "build",
      cmake_build_options = { "-j5" },
      cmake_use_preset = false,
    },

    config = function(_, opts)
      -- Delete cached sessions if present
      local cache_path = vim.fn.expand("~/.cache/cmake_tools_nvim")
      if vim.uv.fs_stat(cache_path) then
        vim.fs.rm(cache_path, { recursive = true })
      end

      require("cmake-tools").setup(opts)

      local which = require("which-key")
      which.add({
        {
          "<leader>m",
          group = "CMake",
          icon = "󱁤",
        },
        {
          "<leader>mg",
          "<cmd>CMakeGenerate<cr>",
          desc = "Generate Project",
        },
        {
          "<leader>mb",
          "<cmd>CMakeBuild<cr>",
          desc = "Build Project",
        },
        {
          "<leader>mr",
          "<cmd>CMakeRun<cr>",
          desc = "Run Target",
        },
        {
          "<leader>mt",
          "<cmd>CMakeSelectBuildTarget<cr>",
          desc = "Select Target",
        },
        {
          "<leader>mx",
          "<cmd>CMakeStop<cr>",
          desc = "Stop/Kill CMake",
        },
      })
    end,
  },
}
