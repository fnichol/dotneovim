local require_or_warn = require("my.utils").require_or_warn

local null_ls_ok, null_ls = require_or_warn("null-ls")
if not null_ls_ok then
  return
end

local mason_null_ls_ok, mason_null_ls = require_or_warn("mason-null-ls")
if not mason_null_ls_ok then
  return
end

-- Usage: https://github.com/jose-elias-alvarez/null-ls.nvim
-- Usage: https://github.com/jay-babu/mason-null-ls.nvim

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions
local root_has_file = require("null-ls.utils").make_conditional_utils().root_has_file

null_ls.setup({
  debug = false,
  on_attach = require("my.lsp.handlers").on_attach,
  diagnostics_format = "[#{c}] #{m}",
  sources = {
    --
    -- ## Formatting
    --
    formatting.prettier.with({
      -- Prefer a project-installed version of Prettier if available
      prefer_local = "node_modules/.bin",
    }),
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
    diagnostics.trail_space,
    diagnostics.vint,
    diagnostics.yamllint,

    --
    -- ## Code Actions
    --
    actions.eslint,
    actions.shellcheck,
  },
})

mason_null_ls.setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
})
