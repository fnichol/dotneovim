-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
--
-- Add any additional override configuration in the following tables. Available keys are:
--
-- - cmd (table): Override the default command used to start the server
-- - filetypes (table): Override the default list of associated filetypes for
--   the server
-- - capabilities (table): Override fields in capabilities. Can be used to
--   disable certain LSP features.
-- - settings (table): Override the default settings passed when initializing
--   the server. For example, to see the options for `lua_ls`, you could go to:
--   https://luals.github.io/wiki/settings/
local lsp_servers = {
  -- Language Server for AWK and associated VSCode client extension
  --
  -- https://github.com/Beaglefoot/awk-language-server/
  awk_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#awk_ls
    settings = {},
  },
  -- A language server for Bash
  --
  -- https://github.com/bash-lsp/bash-language-server
  bashls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
    settings = {},
  },
  -- vscode-langservers bin collection.
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  cssls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
    settings = {},
  },
  -- Language service for Docker Compose documents
  --
  -- https://github.com/microsoft/compose-language-service
  docker_compose_language_service = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#docker_compose_language_service
    settings = {},
  },
  -- A language server for Dockerfiles powered by Node.js, TypeScript, and
  -- VSCode technologies.
  --
  -- https://github.com/rcjsuen/dockerfile-language-server
  dockerls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
    settings = {},
  },
  -- A language server for the DOT language
  --
  -- https://github.com/nikeee/dot-language-server
  dotls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dotls
    settings = {},
  },
  -- gopls, the Go language server
  --
  -- https://github.com/golang/tools/tree/master/gopls
  gopls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
    settings = {},
  },
  -- vscode-langservers bin collection
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  html = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
    settings = {},
  },
  -- vscode-langservers bin collection.
  --
  -- https://github.com/hrsh7th/vscode-langservers-extracted
  jsonls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
    settings = {},
  },
  -- A language server that offers Lua language support - programmed in Lua
  --
  -- https://github.com/luals/lua-language-server
  lua_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
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
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
    settings = {},
  },
  -- A common platform for PowerShell development support in any editor or
  -- application!
  --
  -- https://github.com/PowerShell/PowerShellEditorServices
  powershell_es = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#powershell_es
    settings = {},
  },
  -- Static Type Checker for Python
  --
  -- https://github.com/microsoft/pyright
  pyright = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
    settings = {},
  },
  -- A Rust compiler front-end for IDEs
  --
  -- https://github.com/rust-lang/rust-analyzer
  rust_analyzer = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          -- Favor `cargo clippy` to `cargo check` for diagnostics
          command = "clippy",
        },
        cargo = {
          extraEnv = {
            ["CARGO_PROFILE_RUST_ANALYZER_INHERITS"] = "dev",
          },
          extraArgs = {
            "--profile",
            "rust-analyzer",
          },
        },
      },
    },
  },
  -- SQL Language Server
  --
  -- https://github.com/joe-re/sql-language-server
  sqlls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
    settings = {},
  },
  -- Intelligent Tailwind CSS tooling for Visual Studio Code
  --
  -- https://github.com/tailwindlabs/tailwindcss-intellisense
  tailwindcss = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
    settings = {},
  },
  -- Language server for Taplo, a TOML toolkit.
  --
  -- https://taplo.tamasfe.dev/cli/usage/language-server.html
  taplo = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#taplo
    settings = {},
  },
  -- VImScript language server, LSP for vim script
  --
  -- https://github.com/iamcco/vim-language-server
  vimls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
    settings = {},
  },
  -- -- High-performance Vue language tooling based-on Volar.js
  -- --
  -- -- https://github.com/vuejs/language-tools
  -- volar = {
  --   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
  --   settings = {},
  -- },
  -- Language Server for YAML Files
  --
  -- https://github.com/redhat-developer/yaml-language-server
  yamlls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
    settings = {},
  },
}

local manual_lsp_servers = {
  -- Build system, successor to Buck
  --
  -- https://github.com/facebook/buck2
  buck2 = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#buck2
    settings = {
      -- Use a seperate isolation dir (default: `v2`) for the Buck2 LSP. That
      -- way, cleaning/killing the buckd on the commandline won't kill the
      -- running LSP instance as well.
      cmd = {
        "buck2",
        "--isolation-dir",
        "neovim",
        "lsp",
      },
    },
  },
  -- Tilt Language Server
  --
  -- https://github.com/tilt-dev/tilt
  tilt_ls = {
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tilt_ls
    settings = {},
  },
}

local formatter_tools = {
  "buildifier",
  "prettier",
  "shfmt",
  "stylua",
  "yapf",
}

local linter_tools = {
  "alex",
  "buf",
  "commitlint",
  "eslint",
  "flake8",
  "hadolint",
  "jsonlint",
  "luacheck",
  "markdownlint",
  "shellcheck",
  "vint",
  "yamllint",
}

-- If `buck2` is not present, prevent the LSP from activating
if vim.fn.executable("buck2") ~= 1 then
  manual_lsp_servers["buck2"] = nil
end

-- If `tilt` is not present, prevent the LSP from activating
if vim.fn.executable("tilt") ~= 1 then
  manual_lsp_servers["tilt_ls"] = nil
end

-- If `nix` is not present, don't install & activate the nil LSP
if vim.fn.executable("nix") ~= 1 then
  manual_lsp_servers["nil_ls"] = nil
end

-- If running on OpenBSD, remove language servers and tools that aren't yet
-- supported
if vim.uv.os_uname().sysname == "OpenBSD" then
  lsp_servers["lua_ls"] = nil
  lsp_servers["rust-analyzer"] = nil
  lsp_servers["taplo"] = nil

  formatter_tools["buildifier"] = nil
  formatter_tools["shfmt"] = nil
  formatter_tools["stylua"] = nil
end

return {
  -- Quickstart configs for Neovim LSP
  --
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Portable package manager for Neovim that runs everywhere Neovim runs.
      --
      -- https://github.com/williamboman/mason.nvim
      {
        "williamboman/mason.nvim",
        -- NOTE: Must be loaded before dependants
        config = true,
      },
      -- Extension to mason.nvim that makes it easier to use lspconfig with
      -- mason.nvim.
      --
      -- https://github.com/williamboman/mason-lspconfig.nvim
      { "williamboman/mason-lspconfig.nvim" },
      -- Install and upgrade third party tools automatically
      --
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      -- Extensible UI for Neovim notifications and LSP progress messages.
      --
      -- https://github.com/j-hui/fidget.nvim
      { "j-hui/fidget.nvim", opts = {} },
      -- nvim-cmp source for neovim builtin LSP client
      --
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      -- LSP provides Neovim with features like:
      -- - Go to definition
      -- - Find references
      -- - Autocompletion
      -- - Symbol Search
      -- - and more!
      --
      -- Thus, Language Servers are external tools that must be installed
      -- separately from Neovim. This is where `mason` and related plugins come
      -- into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the
      -- wonderfully and elegantly composed help section,
      -- `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --
      --  That is to say, every time a new file is opened that is associated
      --  with an lsp (for example, opening `main.rs` is associated with
      --  `rust_analyzer`) this function will be executed to configure the
      --  current buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
        callback = function(event)
          local keymap = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc .. " (LSP)" })
          end

          local builtin = require("telescope.builtin")

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function
          -- is defined, etc.
          -- To jump back, press `<C-t>`.
          -- keymap("n", "gd", builtin.lsp_definitions, "Goto Definition")
          keymap("n", "gd", vim.lsp.buf.definition, "Goto Definition")

          -- Jump to the declaration of the word under your cursor.
          -- For example, in C this would take you to the header.
          keymap("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

          -- Jump to the implementation of the word under your cursor.
          -- Useful when your language has ways of declaring types without an
          -- actual implementation.
          -- keymap("n", "gI", builtin.lsp_implementations, "Goto Implementation")
          keymap("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")

          -- Signature help represents the signature of something callable.
          -- There can be multiple signature but only one active and only one
          -- active parameter
          keymap("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
          keymap("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")

          -- Find references for the word under your cursor.
          -- keymap("n", "gr", builtin.lsp_references, "Goto References")
          keymap("n", "gr", vim.lsp.buf.references, "Goto References")

          keymap("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")

          keymap("n", "<leader>li", "<cmd>LspInfo<CR>", "LSP Info")

          keymap("n", "K", vim.lsp.buf.hover, "Hover Documentation")

          -- Execute a code action, usually your cursor needs to be on top of
          -- an error or a suggestion from your LSP for this to activate.
          keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")

          keymap({ "n", "v" }, "<leader>lc", vim.lsp.codelens.run, "Run CodeLens")

          keymap("n", "<leader>lC", vim.lsp.codelens.refresh, "Refresh & Display CodeLens")

          keymap("n", "<leader>lr", vim.lsp.buf.rename, "Rename")

          keymap("n", "<leader>ls", builtin.lsp_document_symbols, "Document Symbols")

          keymap("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          -- The following two autocommands are used to highlight references of
          -- the word under your cursor when your cursor rests there for a
          -- little while.
          --
          -- See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the
          -- second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
          then
            local highlight_augroup =
              vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            keymap("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what
      -- features they support.
      --
      -- By default, Neovim doesn't support everything that is in the LSP
      -- specification. When you add nvim-cmp, luasnip, etc. Neovim now has
      -- *more* capabilities. So, we create new capabilities with nvim cmp, and
      -- then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run `:Mason`
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()

      -- You can add other tools here that you want Mason to install for you,
      -- so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(lsp_servers or {})
      vim.list_extend(ensure_installed, formatter_tools)
      vim.list_extend(ensure_installed, linter_tools)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      -- Combine all LSP servers together and error if there's any overlap
      local all_lsp_servers = vim.tbl_deep_extend("error", {}, lsp_servers, manual_lsp_servers)

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = all_lsp_servers[server_name] or {}
            -- This handles overriding only values explicitly passed by the
            -- server configuration above. Useful when disabling certain
            -- features of an LSP (for example, turning off formatting for
            -- tsserver)
            server.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
  -- Faster LuaLS setup for Neovim
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and
  -- plugins used for completion, annotations and signatures of Neovim apis
  --
  -- https://github.com/folke/lazydev.nvim
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- Meta type definitions for the Lua platform Luvit.
  --
  -- https://github.com/Bilal2453/luvit-meta
  { "Bilal2453/luvit-meta", lazy = true },
  -- VSCode 💡 for neovim's built-in LSP.
  --
  -- https://github.com/kosayoda/nvim-lightbulb
  { "kosayoda/nvim-lightbulb" },
  -- (Neo)Vim plugin for automatically highlighting other uses of the word
  -- under the cursor using either LSP, Tree-sitter, or regex matching.
  --
  -- https://github.com/RRethy/vim-illuminate
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        -- Disable plugin if the file is very large (number of lines)
        large_file_cutoff = 10000,
      })
    end,
  },
}
