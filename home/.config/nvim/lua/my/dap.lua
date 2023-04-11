local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

local dap_ok, dap = require_or_warn("dap")
if not dap_ok then
  return
end

local dapui_ok, dapui = require_or_warn("dapui")
if not dapui_ok then
  return
end

local mason_nvim_dap_ok, mason_nvim_dap = require_or_warn("mason-nvim-dap")
if not mason_nvim_dap_ok then
  return
end

-- Usage: https://github.com/mfussenegger/nvim-dap
-- Usage: https://github.com/jay-babu/mason-nvim-dap.nvim
-- Usage: https://github.com/rcarriga/nvim-dap-ui

local sources = {
  "bash",
  "codelldb",
}

if vim.loop.os_uname().sysname == "OpenBSD" then
  local remove_value = utils.table.remove_value

  remove_value(sources, "codelldb")
end

mason_nvim_dap.setup({
  ensure_installed = sources,
  automatic_installation = true,
  automatic_setup = true,
})

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
