local utils = require("my.utils")
local notify = utils.notify
local require_or_warn = utils.require_or_warn

local j_ok, Job = require_or_warn("plenary.job")
if not j_ok then
  return
end

local pkg = "pynvim"

M = {}

local detect = function()
  if vim.fn.executable("python3") ~= 1 then
    notify.error("python3 not found which is required. Please install Python 3 and retry.")
    return false
  end

  local job = Job:new({
    command = "python3",
    args = { "-m", "pip", "freeze", "--user" },
    enable_recording = true,
  })
  job:sync()
  if job.code == 0 then
    local pattern = string.format("^%s==.*$", pkg)
    for _, line in ipairs(job:result()) do
      if string.find(line, pattern) ~= nil then
        return true
      end
    end
    return false
  else
    notify.error("failed to detect python package: %s", pkg)
    return false
  end
end

local add_install_command = function()
  -- TODO: When v0.7 is released: https://github.com/nanotee/nvim-lua-guide#defining-user-commands
  vim.api.nvim_exec(
    [[command! -nargs=0 -bar InstallPynvim lua require("my.install.pynvim").install()]],
    false
  )
end

local remove_install_command = function()
  -- TODO: When v0.7 is released: https://github.com/nanotee/nvim-lua-guide#defining-user-commands
  vim.api.nvim_exec([[delcommand InstallPynvim]], false)
end

M.add_install_command_if_not_detected = function()
  if not require("my.install.pynvim").detect() then
    require("my.install.pynvim").add_install_command()
  end
end

M.install = function()
  if vim.fn.executable("python3") ~= 1 then
    notify.error("python3 not found which is required. Please install Python 3 and retry.")
    return false
  end

  -- python3 -m pip install --user --upgrade pynvim
  local job = Job:new({
    command = "python3",
    args = { "-m", "pip", "install", "--user", "--upgrade", pkg },
  })
  job:sync()
  if job.code == 0 then
    remove_install_command()
    notify.info("Installation of '%s' complete", pkg)
    return true
  else
    notify.error("Failed to install '%s'\n\n%s", pkg, table.concat(job:stderr_result(), "\n"))
    return false
  end
end

M.detect = detect
M.add_install_command = add_install_command
M.remove_install_command = remove_install_command

return M
