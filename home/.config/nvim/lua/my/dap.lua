local require_or_warn = require("my.utils").require_or_warn

local dap_install_ok, dap_install = require_or_warn("dap-install")
if not dap_install_ok then
  return
end

local dap_ok, dap = require_or_warn("dap")
if not dap_ok then
  return
end

local dapui_ok, dapui = require_or_warn("dapui")
if not dapui_ok then
  return
end

-- Usage: https://github.com/Pocco81/DAPInstall.nvim
-- Usage: https://github.com/mfussenegger/nvim-dap
-- Usage: https://github.com/rcarriga/nvim-dap-ui

-- Configure every currently installed debugger
for _, debugger in ipairs(require("dap-install.api.debuggers").get_installed_debuggers()) do
  dap_install.config(debugger)
end

dapui.setup()

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
