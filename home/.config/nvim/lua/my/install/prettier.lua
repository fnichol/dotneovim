local utils = require("my.utils")
local notify = utils.notify
local require_or_warn = utils.require_or_warn

local program = "prettier"

M = {}

local detect = function()
  return vim.fn.executable(program) == 1
end

local add_install_command = function()
  -- TODO: When v0.7 is released: https://github.com/nanotee/nvim-lua-guide#defining-user-commands
  vim.api.nvim_exec(
    [[command! -nargs=0 -bar -buffer InstallPrettier lua require("my.install.prettier").install()]],
    false
  )
end

local remove_install_command = function()
  -- TODO: When v0.7 is released: https://github.com/nanotee/nvim-lua-guide#defining-user-commands
  vim.api.nvim_exec([[delcommand InstallPrettier]], false)
end

M.add_install_command_if_not_detected = function()
  if not require("my.install.prettier").detect() then
    require("my.install.prettier").add_install_command()
  end
end

M.install = function()
  local ok, Job = require_or_warn("plenary.job")
  if not ok then
    return
  end

  if vim.fn.executable("npm") ~= 1 then
    notify.error("npm not found which is required. Please install Node and retry.")
    return false
  end

  local job = Job:new({ command = "npm", args = { "install", "-g", program } })
  job:sync()
  if job.code == 0 then
    remove_install_command()
    notify.info("Installation of '%s' complete", program)
    return true
  else
    notify.error("Failed to install '%s'\n\n%s", program, table.concat(job:stderr_result(), "\n"))
    return false
  end
end

M.detect = detect
M.add_install_command = add_install_command
M.remove_install_command = remove_install_command

return M
