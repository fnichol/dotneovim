local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
  vim.notify("[my.lsp.lsp-installer] failed to require 'nvim-lsp-installer'", WARN)
  return
end

-- Usage: https://github.com/williamboman/nvim-lsp-installer

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("my.lsp.handlers").on_attach,
    capabilities = require("my.lsp.handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("my.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  server:setup(opts)
end)
