M = {}

local packages = {
  -- Build system, successor to Buck
  --
  -- https://github.com/facebook/buck2
  buck2 = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buck2
    --
    -- Use a seperate isolation dir (default: `v2`) for the Buck2 LSP. That
    -- way, cleaning/killing the buckd on the commandline won't kill the
    -- running LSP instance as well.
    cmd = {
      "buck2",
      "--isolation-dir",
      "neovim",
      "lsp",
    },
    settings = {},
  },
  -- Tilt Language Server
  --
  -- https://github.com/tilt-dev/tilt
  tilt_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tilt_ls
    settings = {},
  },
}

-- If `buck2` is not present, prevent the LSP from activating
if vim.fn.executable("buck2") ~= 1 then
  packages["buck2"] = nil
end

-- If `tilt` is not present, prevent the LSP from activating
if vim.fn.executable("tilt") ~= 1 then
  packages["tilt_ls"] = nil
end

M.configuration = packages

return M
