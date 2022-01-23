local ok, _ = pcall(require, "lspconfig")
if not ok then
  vim.notify("[my.lsp] failed to require 'lspconfig'", WARN)
  return
end

require("my.lsp.lsp-installer")
require("my.lsp.handlers").setup()
-- require("my.lsp.null-ls")
