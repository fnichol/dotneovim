local require_or_warn = require("my.utils").require_or_warn

local ok, lsp_installer = require_or_warn("nvim-lsp-installer")
if not ok then
  return
end

-- Usage: https://github.com/williamboman/nvim-lsp-installer

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("my.lsp.handlers").on_attach,
    capabilities = require("my.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("my.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", opts, jsonls_opts)
  end

  if server.name == "rust_analyzer" then
    local rust_analyzer_opts = require("my.lsp.settings.rust_analyzer")
    opts = vim.tbl_deep_extend("force", opts, rust_analyzer_opts)

    require("my.lsp.rust-tools").setup(server, opts)
    return
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("my.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", opts, sumneko_opts)
  end

  if server.name == "volar" then
    local volar_opts = require("my.lsp.settings.volar")
    opts = vim.tbl_deep_extend("force", opts, volar_opts)
  end

  server:setup(opts)
end)
