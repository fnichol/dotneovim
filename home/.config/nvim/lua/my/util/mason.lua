M = {}

local ensure_installed_list = function()
  local lsps = require("my.mason.lsps").install()
  local mason_install_only_lsps = require("my.mason.lsps_install_only").install()
  local formatters = require("my.mason.formatters").install()
  local linters = require("my.mason.linters").install()
  local daps = require("my.mason.daps").install()

  -- You can add other tools here that you want Mason to install for you,
  -- so that they are available from within Neovim.
  local ensure_installed = lsps or {}
  vim.list_extend(ensure_installed, mason_install_only_lsps or {})
  vim.list_extend(ensure_installed, formatters or {})
  vim.list_extend(ensure_installed, linters or {})
  vim.list_extend(ensure_installed, daps or {})

  return ensure_installed
end
M.ensure_installed_list = ensure_installed_list

return M
