local ok, null_ls = pcall(require, "null-ls")
if not ok then
  vim.notify("[my.null-ls] failed to require 'null-ls'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/jose-elias-alvarez/null-ls.nvim

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
local root_has_file = require("null-ls.utils").make_conditional_utils().root_has_file

null_ls.setup({
  debug = false,
  diagnostics_format = "[#{c}] #{m}",
  sources = {
    --
    -- ## Formatting
    --
    formatting.prettier,
    formatting.stylua.with({
      condition = function(utils)
        -- Only format Lua code that have a StyLua configuration
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
    }),
    formatting.shfmt.with({
      extra_args = function(_)
        -- If an EditorConfig config is set for the project, use this,
        -- otherwise fall back to the Google shell style conventions
        -- (https://google.github.io/styleguide/shell.xml)
        if root_has_file({ ".editorconfig" }) then
          return {}
        else
          return { "-i", "2", "-bn", "-ci" }
        end
      end,
    }),

    --
    -- ## Diagnostics
    --
    diagnostics.eslint,
    diagnostics.hadolint,
    diagnostics.jsonlint,
    diagnostics.shellcheck,
    diagnostics.yamllint,

    --
    -- ## Code Actions
    --
    actions.eslint,
    actions.shellcheck,
  },
})
