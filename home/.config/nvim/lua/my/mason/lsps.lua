M = {}

local vue_language_server_path = vim.fs.joinpath(
  vim.fn.expand("$MASON"),
  "packages",
  "vue-language-server",
  "node_modules",
  "@vue",
  "language-server"
)

local file_exists = function(path)
  return (vim.uv.fs_stat(path) or {}).type == "file"
end

---@type table<string, vim.lsp.Config>
local configuration = {
  -- Language Server for AWK and associated VSCode client extension
  --
  -- https://github.com/Beaglefoot/awk-language-server/
  awk_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#awk_ls
    settings = {},
  },
  -- A language server for Bash
  --
  -- https://github.com/bash-lsp/bash-language-server
  bashls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls
    settings = {},
  },
  -- vscode-langservers bin collection.
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  cssls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
    settings = {},
  },
  -- Deno's built-in language server
  --
  -- https://github.com/denoland/deno
  denols = {
    workspace_required = true,
    -- Determine if a language server should be attached to each buffer based
    -- on project marker files
    root_dir = function(bufnr, on_dir)
      local ts_markers = { "package.json", "tsconfig.json" }
      local deno_markers = { "deno.json", "deno.jsonc" }

      local bufname = vim.api.nvim_buf_get_name(bufnr)

      for dir in vim.fs.parents(bufname) do
        -- Deno project marker files signifies a Deno project path which supersede a TS project
        for _, deno_marker in pairs(deno_markers) do
          if file_exists(vim.fs.joinpath(dir, deno_marker)) then
            -- Found a Deno project marker file, attaching language server
            on_dir(dir)
            return
          end
        end

        -- Now finding a TS project marker file signifies a TS project
        for _, ts_marker in pairs(ts_markers) do
          local candidate = vim.fs.joinpath(dir, ts_marker)
          if file_exists(candidate) then
            -- Found a TS project marker file, skipping language server
            return
          end
        end

        if vim.fn.isdirectory(vim.fs.joinpath(dir, ".git")) == 1 then
          -- Failed to find a marker file before finding Git repo root, skipping language server
          return
        end
      end
    end,
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#denols
    settings = {
      typscript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
  -- Language service for Docker Compose documents
  --
  -- https://github.com/microsoft/compose-language-service
  docker_compose_language_service = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#docker_compose_language_service
    settings = {},
  },
  -- A language server for Dockerfiles powered by Node.js, TypeScript, and
  -- VSCode technologies.
  --
  -- https://github.com/rcjsuen/dockerfile-language-server
  dockerls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dockerls
    settings = {},
  },
  -- A language server for the DOT language
  --
  -- https://github.com/nikeee/dot-language-server
  dotls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#dotls
    settings = {},
  },
  -- gopls, the Go language server
  --
  -- https://github.com/golang/tools/tree/master/gopls
  gopls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gopls
    settings = {},
  },
  -- vscode-langservers bin collection
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  html = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html
    settings = {},
  },
  -- vscode-langservers bin collection.
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  jsonls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
    settings = {},
  },
  -- A language server that offers Lua language support - programmed in Lua
  --
  -- https://github.com/luals/lua-language-server
  lua_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  -- NIx Language server, an incremental analysis assistant for writing in Nix.
  --
  -- https://github.com/oxalica/nil
  nil_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nil_ls
    settings = {},
  },
  -- A common platform for PowerShell development support in any editor or
  -- application!
  --
  -- https://github.com/PowerShell/PowerShellEditorServices
  powershell_es = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#powershell_es
    settings = {},
  },
  -- Static Type Checker for Python
  --
  -- https://github.com/microsoft/pyright
  pyright = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyright
    settings = {},
  },
  -- SQL Language Server
  --
  -- https://github.com/joe-re/sql-language-server
  sqlls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#sqlls
    settings = {},
  },
  -- Intelligent Tailwind CSS tooling for Visual Studio Code
  --
  -- https://github.com/tailwindlabs/tailwindcss-intellisense
  tailwindcss = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tailwindcss
    settings = {},
  },
  -- Language server for Taplo, a TOML toolkit.
  --
  -- https://taplo.tamasfe.dev/cli/usage/language-server.html
  taplo = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#taplo
    settings = {},
  },
  -- Language server for TypeScript that wraps `tsserver`
  --
  -- https://github.com/typescript-language-server/typescript-language-server
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
    workspace_required = true,
    -- Determine if a language server should be attached to each buffer based
    -- on project marker files
    root_dir = function(bufnr, on_dir)
      local ts_markers = { "package.json", "tsconfig.json" }
      local deno_markers = { "deno.json", "deno.jsonc" }

      local bufname = vim.api.nvim_buf_get_name(bufnr)

      for dir in vim.fs.parents(bufname) do
        -- Deno project marker files signifies a Deno project path which supersede a TS project
        for _, deno_marker in pairs(deno_markers) do
          if file_exists(vim.fs.joinpath(dir, deno_marker)) then
            -- Found a Deno project marker file, skipping language server
            return
          end
        end

        -- Now finding a TS project marker file signifies a TS project
        for _, ts_marker in pairs(ts_markers) do
          if file_exists(vim.fs.joinpath(dir, ts_marker)) then
            -- Found a TS project marker file, attaching language server
            on_dir(dir)
            return
          end
        end

        if vim.fn.isdirectory(vim.fs.joinpath(dir, ".git")) == 1 then
          -- Failed to find a marker file before finding Git repo root, skipping language server
          return
        end
      end
    end,
    filetypes = {
      "javascript",
      "javascript.jsx",
      "javascriptreact",
      "typescript",
      "typescript.tsx",
      "typescriptreact",
      "vue",
    },
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },

      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
  -- VImScript language server, LSP for vim script
  --
  -- https://github.com/iamcco/vim-language-server
  vimls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vimls
    settings = {},
  },
  -- Language Server for YAML Files
  --
  -- https://github.com/redhat-developer/yaml-language-server
  yamlls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#yamlls
    settings = {},
  },
}

-- If running on OpenBSD, remove language servers and tools that aren't yet
-- supported
if vim.uv.os_uname().sysname == "OpenBSD" then
  configuration["denols"] = nil
  configuration["lua_ls"] = nil
  configuration["rust_analyzer"] = nil
  configuration["taplo"] = nil
end

-- If `nix` is not present, don't install & activate the nil LSP
if vim.fn.executable("nix") ~= 1 then
  configuration["nil_ls"] = nil
end

M.configuration = configuration

return M
