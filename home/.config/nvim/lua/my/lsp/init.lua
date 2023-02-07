local require_or_warn = require("my.utils").require_or_warn

local status_ok, _ = require_or_warn("lspconfig")
if not status_ok then
  return
end

require("my.lsp.fidget")
require("my.lsp.mason")
require("my.lsp.handlers").setup()
require("my.lsp.null-ls")
