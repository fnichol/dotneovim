local mason_servers = {
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
  "lua_ls",
  "nil_ls",
  "rust_analyzer",
  "powershell_es",
  "pyright",
  "sqlls",
  -- "tsserver",
  "taplo",
  "tailwindcss",
  "vimls",
  "volar",
  "yamlls",
}

local manual_servers = {
  "buck2",
}

local utils = require("my.utils")
local require_or_warn = utils.require_or_warn
local remove_value = utils.table.remove_value

if vim.loop.os_uname().sysname == "OpenBSD" then
  remove_value(mason_servers, "lua_ls")
  remove_value(mason_servers, "rust_analyzer")
  remove_value(mason_servers, "taplo")
end

-- If `buck2` is not present, prevent the LSP from activating
if vim.fn.executable("buck2") ~= 1 then
  remove_value(manual_servers, "buck2")
end

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
    },
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
  ensure_installed = mason_servers,
  automatic_installation = true,
})

for _, servers in pairs({ mason_servers, manual_servers }) do
  for _, server in pairs(servers) do
    server = vim.split(server, "@")[1]

    local conf_opts_ok, conf_opts = require_or_warn("my.lsp.settings." .. server)

    if conf_opts_ok then
      local default_opts = {
        on_attach = require("my.lsp.handlers").on_attach,
        capabilities = require("my.lsp.handlers").capabilities,
      }
      local opts = vim.tbl_deep_extend("force", {}, default_opts, conf_opts or {})

      if server == "rust_analyzer" then
        -- Load and configure `rust-tools` which in turn sets up `rust_analyzer`
        local rust_tools_ok, rust_tools = require_or_warn("my.lsp.rust-tools")
        if not rust_tools_ok then
          return
        end

        rust_tools.setup(opts)
      else
        lspconfig[server].setup(opts)
      end
    end
  end
end
