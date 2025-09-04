-- This file defines a custom command and keymap to run the current
-- project's Makefile or the currently open file.
--
-- To use this, save it as a file like 'run_project.lua' in your
-- 'lua' directory (e.g., ~/.config/nvim/lua/run_project.lua)
-- and then 'require' it in your init.lua:
--
-- require('run_project')

-- A helper function to find the project root.
-- It searches for common root markers like a .git directory or a Makefile.
local function get_project_root()
  -- Get the current working directory
  local cwd = vim.fn.getcwd()

  -- Search for a root marker up the directory tree
  -- We'll look for a '.git' directory or a 'Makefile'
  local root = vim.fs.find({ "Makefile", ".git" }, {
    up = true,
    stop = cwd,
  })[1]

  -- Return the directory of the found file, or the current directory if none is found.
  return root and vim.fs.dirname(root) or cwd
end

-- A helper function to execute a command in a new terminal buffer.
local function run_in_terminal(command, options)
  options = options or {}
  local cmd = "silent term " .. command
  vim.cmd(cmd)
end

-- Define the main logic for our custom command.
local function run_project()
  local root_dir = vim.fn.getcwd()
  print(root_dir)
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if a Makefile exists in the project root
  if vim.fn.filereadable(root_dir .. "/Makefile") ~= 0 then
    print("Running make in project root...")
    run_in_terminal("make -C " .. root_dir)
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

-- Create the user command :RunProject
-- The {} at the end is for command options, which we don't need here.
vim.api.nvim_create_user_command("RunProject", run_project, {})

-- Create a keymap for convenience.
-- We'll map it to <leader>r (e.g., \r by default).
vim.keymap.set("n", "<leader>r", ":RunProject<CR>", {
  noremap = true,
  silent = true,
  desc = "Run the current project or file",
})
