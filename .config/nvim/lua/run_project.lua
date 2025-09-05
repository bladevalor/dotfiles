-- This file defines a custom command and keymap to run the current
-- project's Makefile or the currently open file.

local function get_project_root()
  local cwd = vim.fn.getcwd()

  -- Search for a root marker up the directory tree
  local root = vim.fs.find({ "Makefile", ".git", "CMakeLists.txt" }, {
    up = true,
    stop = cwd,
  })[1]

  return root and vim.fs.dirname(root) or cwd
end

local function run_in_terminal(command, options)
  options = options or {}
  local cmd = "silent term " .. command
  vim.cmd(cmd)
end

-- Define the main logic for our custom command.
local function run_project()
  local root_dir = get_project_root()
  print(root_dir)
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if a Makefile exists in the project root
  if vim.fn.filereadable(root_dir .. "/Makefile") ~= 0 then
    print("Running make in project root...")
    run_in_terminal("make -C " .. root_dir)
  elseif vim.fn.filereadable(root_dir .. "/CMakeLists.txt") ~= 0 then
    print("Running CMake build...")
    local build_dir = root_dir .. "/build"
    vim.fn.mkdir(build_dir, "p")

    local cmake_setup = "cmake -S " .. root_dir .. " -B " .. build_dir
    local cmake_build = "cmake --build " .. build_dir
    local cmake_run = build_dir .. "/bin/pocket"
    local run_command = cmake_setup .. " && " .. cmake_build .. " && " .. cmake_run

    run_in_terminal(run_command)
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
