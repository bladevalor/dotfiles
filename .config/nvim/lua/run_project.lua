-- This file defines a custom command and keymap to run the current
-- project's Makefile or the currently open file.

local get_project_root = function()
  local cwd = vim.fn.getcwd()

  local root = vim.fs.find({ "Makefile", ".git", "CMakeLists.txt" }, {
    up = true,
    stop = cwd,
  })[1]

  return root and vim.fs.dirname(root) or cwd
end

local run_in_terminal = function(command, options)
  options = options or {}
  local cmd = "silent term " .. command
  vim.cmd(cmd)
end

-- Handle CMake projects
local CMake_runner = function(root_dir)
  local build_dir = root_dir .. "/build"
  vim.fn.mkdir(build_dir, "p")

  -- cmake terminal/console commands
  local cmake_build = "cmake --build " .. build_dir

  -- build and redirect errors to quickfix List
  local output_file = vim.fn.tempname()
  vim.fn.system(cmake_build .. " 2> " .. output_file)

  local error_formats = {
    "%f:%l:%c: %m",
    "%E%f:%l:%c: error: %m",
    "%E%f:%l:%c: fatal error: %m",
    "%-G%.%#",
  }

  vim.fn.setqflist({}, "r", {
    efm = table.concat(error_formats, ","),
    lines = vim.fn.readfile(output_file),
  })

  -- check quickfix List for errors
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then
    vim.cmd("cclose")
    print("✅ Build Success")
    run_in_terminal(build_dir .. "/bin/pocket")
    return
  end

  print("❌ Build Fail")
  vim.cmd("cfirst")
end

-- Define the main logic for our custom command.
local function run_project()
  local root_dir = get_project_root()
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if a Makefile exists in the project root
  if vim.fn.filereadable(root_dir .. "/Makefile") ~= 0 then
    print("Running make in project root...")
    run_in_terminal("make -C " .. root_dir)
  elseif vim.fn.filereadable(root_dir .. "/CMakeLists.txt") ~= 0 then
    CMake_runner(root_dir)
  else
    -- If no Makefile, try to run the current file based on its extension
    local run_command
    if current_file:match("%.py$") then
      -- Python file
      run_command = "python " .. current_file
    elseif current_file:match("%.js$") then
      -- JavaScript file with Node.js
      run_command = "node " .. current_file
    elseif current_file:match("%.go$") then
      -- Go file
      run_command = "go run " .. current_file
    elseif current_file:match("%.rs$") then
      -- Rust file (using rustc for a simple case)
      run_command = "rustc " .. current_file .. " && ./" .. current_file:gsub("%.rs$", "")
    elseif current_file:match("%.c$") then
      -- C file (using gcc)
      run_command = "gcc "
        .. current_file
        .. " -o "
        .. current_file:gsub("%.c$", "")
        .. " && ./"
        .. current_file:gsub("%.c$", "")
    else
      -- Fallback if no specific run command is found
      print("Could not find a Makefile or a recognized file type to run.")
      return
    end

    print("Running " .. run_command .. "...")
    run_in_terminal(run_command)
  end
end

vim.api.nvim_create_user_command("RunProject", run_project, {})

-- Create a keymap for convenience.
vim.keymap.set("n", "<leader>r", ":RunProject<CR>", {
  noremap = true,
  silent = true,
  desc = "Run the current project or file",
})
