M = {}

local packages = {
  -- The official language server for Vue
  --
  -- Note: only needs to be installed to be used by the `ts_ls` LSP.
  --
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue_ls
  "vue_ls",
}

M.packages = packages

return M
