local servers = {
  "awk_ls",
  "bashls",
  "cssls",
  "dockerls",
  "dotls",
  -- "eslint",
  "gopls",
  -- "graphql",
  "html",
  "jsonls",
  "rust_analyzer",
  "powershell_es",
  "pyright",
  "sqlls",
  "sumneko_lua",
  -- "tsserver",
  "taplo",
  "tailwindcss",
  "vimls",
  "volar",
  "yamlls",
}

local require_or_warn = require("my.utils").require_or_warn

local lspconfig_ok, lspconfig = require_or_warn("lspconfig")
if not lspconfig_ok then
  return
end

local mason_ok, mason = require_or_warn("mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = require_or_warn("mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

-- Usage: https://github.com/williamboman/mason.nvim
-- Usage: https://github.com/williamboman/mason-lspconfig.nvim

local mason_settings = {
  ui = {
    -- The border to use for the UI window. Accepts same border values as
    -- |nvim_open_win()|.
    border = "none",
    icons = {
      -- The list icon to use for installed packages.
      package_installed = "◍",
      -- The list icon to use for packages that are installing, or queued for
      -- installation.
      package_pending = "◍",
      -- The list icon to use for packages that are not installed.
      package_uninstalled = "◍",
    }
  },
  -- Controls to which degree logs are written to the log file. It's useful to
  -- set this to vim.log.levels.DEBUG when debugging issues with package
  -- installations.
  log_level = vim.log.levels.INFO,
  -- Limit for the maximum amount of packages to be installed at the same time.
  -- Once this limit is reached, any further packages that are requested to be
  -- installed will be put in a queue.
  max_concurrent_installers = 4,
}

mason.setup(mason_settings)

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local opts = {}


for _, server in pairs(servers) do
  opts = {
    on_attach = require("my.lsp.handlers").on_attach,
    capabilities = require("my.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = require_or_warn("my.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
