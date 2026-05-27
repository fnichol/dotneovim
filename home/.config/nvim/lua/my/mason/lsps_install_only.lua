M = {}

local sys = require("my.util.sys")

local packages = {
  -- A Rust compiler front-end for IDEs
  --
  -- NOTE: this configuration only ensures that the binary is installed via
  -- Mason. Configuration is provided via the `rustaceanvim` plugin.
  --
  -- https://github.com/rust-lang/rust-analyzer
  rust_analyzer = {
    -- Mason package not available on OpenBSD
    install_condition = function()
      return not sys.on_openbsd()
    end,
  },
  -- The official language server for Vue
  --
  -- NOTE: only needs to be installed to be used by the `ts_ls` LSP.
  --
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue_ls
  vue_ls = {},
}

local table = require("my.util.table")

M.install = function()
  return table.filter_install_list(packages)
end

return M
