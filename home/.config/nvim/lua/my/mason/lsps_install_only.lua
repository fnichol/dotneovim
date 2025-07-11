M = {}

local packages = {
  -- A Rust compiler front-end for IDEs
  --
  -- NOTE: this configuration only ensures that the binary is installed via
  -- Mason. Configuration is provided via the `rustaceanvim` plugin.
  --
  -- https://github.com/rust-lang/rust-analyzer
  "rust_analyzer",
  -- The official language server for Vue
  --
  -- NOTE: only needs to be installed to be used by the `ts_ls` LSP.
  --
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue_ls
  "vue_ls",
}

M.packages = packages

return M
