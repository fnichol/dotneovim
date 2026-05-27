M = {}

local filter_table = function(tbl)
  return require("my.util.table").filter_map(tbl, function(_, val)
    if val["install_and_use_condition"] ~= nil then
      return val["install_and_use_condition"]()
    else
      return true
    end
  end, function(key, val)
    local new_val = vim.deepcopy(val)
    new_val["install_and_use_condition"] = nil
    return key, new_val
  end)
end

---@type table<string, vim.lsp.Config>
local packages = {
  -- Build system, successor to Buck
  --
  -- https://github.com/facebook/buck2
  buck2 = {
    install_and_use_condition = function()
      -- Only use if `buck2` program is present
      return vim.fn.executable("buck2") == 1
    end,
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
    install_and_use_condition = function()
      -- Only use if `tilt` program is present
      return vim.fn.executable("tilt") == 1
    end,
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tilt_ls
    settings = {},
  },
}

M.configuration = function()
  return filter_table(packages)
end

return M
