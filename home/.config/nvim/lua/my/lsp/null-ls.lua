local ok, null_ls = pcall(require, "null-ls")
if not ok then
  vim.notify("[my.null-ls] failed to require 'null-ls'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/jose-elias-alvarez/null-ls.nvim

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier,
    formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),
    formatting.shfmt,

    diagnostics.eslint,
    diagnostics.shellcheck,

    actions.eslint,
  },
})
