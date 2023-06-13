-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#buck2

return {
  -- Use a seperate isolation dir (default: `v2`) for the Buck2 LSP. That way,
  -- cleaning/killing the buckd on the commandline won't kill the running LSP
  -- instance as well.
  cmd = {
    "buck2",
    "--isolation-dir",
    "neovim",
    "lsp",
  },
}
