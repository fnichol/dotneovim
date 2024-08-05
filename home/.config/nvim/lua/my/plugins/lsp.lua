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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
local rust_analyzer_settings = {
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
}

local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

local diagnostic_config = {
  -- Options for floating diagnostic windows
  float = {
    -- Border window style
    border = "rounded",
    -- Don't make the floating window focusable
    focusable = false,
    -- String to use as the header for the floating window
    header = "",
    -- Prefix each diagnostic in the floating window
    prefix = "",
    -- Include the diagnostic source in the message
    source = "always",
    -- NeoVim will display the window with many UI options disabled
    style = "minimal",
  },
  -- Use signs for diagnostics
  signs = { active = diagnostic_signs },
  -- Use underline for diagnostics [default: true]
  underline = true,
  -- Update diagnostics in Insert mode [default: false]
  update_in_insert = true,
  -- Sort diagnostics by severity [default: false]
  severity_sort = true,
  -- Use virtual text for diagnostics [default: true]
  virtual_text = true,
}

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

          local rust_ft = vim.bo[event.buf].filetype == "rust"
          local cargo_toml = vim.fs.basename(vim.api.nvim_buf_get_name(0)) == "Cargo.toml"

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

          if cargo_toml then
            keymap("n", "K", function()
              require("crates").show_popup()
            end, "Hover Crate Documentation")
          else
            keymap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          end

          -- Execute a code action, usually your cursor needs to be on top of
          -- an error or a suggestion from your LSP for this to activate.
          if rust_ft then
            keymap({ "n", "v" }, "<leader>la", function()
              vim.cmd.RustLsp("codeAction")
            end, "Code Action")
          else
            keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code Action")
          end

          keymap({ "n", "v" }, "<leader>lc", vim.lsp.codelens.run, "Run CodeLens")

          keymap("n", "<leader>lC", vim.lsp.codelens.refresh, "Refresh & Display CodeLens")

          keymap("n", "<leader>lr", vim.lsp.buf.rename, "Rename")

          keymap("n", "<leader>ls", builtin.lsp_document_symbols, "Document Symbols")

          keymap("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          if rust_ft then
            keymap("n", "gC", function()
              vim.cmd.RustLsp("openCargo")
            end, "Open Rust Cargo.toml")

            keymap("n", "gP", function()
              vim.cmd.RustLsp("parentModule")
            end, "Goto Rust Parent Module")

            keymap("n", "<leader>lD", function()
              vim.cmd.RustLsp("openDocs")
            end, "Open docs.rs Documentation")

            keymap("n", "<leader>le", function()
              vim.cmd.RustLsp("expandMacro")
            end, "Expand Rust Macro")

            keymap("n", "<leader>lE", function()
              vim.cmd.RustLsp("rebuildProcMacros")
            end, "Rebuild Rust Proc Macros")

            keymap("n", "<leader>lh", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, "Rust Hover Actions")
            keymap("v", "<leader>lh", function()
              vim.cmd.RustLsp({ "hover", "range" })
            end, "Rust Range Actions")

            keymap("n", "<leader>lR", function()
              vim.cmd.RustLsp("runnables")
            end, "Rust Runnables")

            keymap("n", "<leader>lx", function()
              vim.cmd.RustLsp({ "explainError", "current" })
            end, "Explain Current Rust Error")
          end

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

      for _, sign in pairs(diagnostic_signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end
      vim.diagnostic.config(diagnostic_config)
      -- Set rounded corners on hover windows
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      -- Set rounded corners on signature help windows
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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

      -- -- Ensure the servers and tools above are installed
      -- --
      -- -- To check the current status of installed tools and/or manually install
      -- -- other tools, you can run `:Mason`
      -- --
      -- --  You can press `g?` for help in this menu.
      -- require("mason").setup()

      -- Delete the bin symlink to the `rust-analyzer` Mason package binary when installed.
      --
      -- By default, Mason will add this "symlink bin" directory to the *front*
      -- of the editor's `$PATH`, meaning that any Mason-installed program will
      -- be found before a system equivalent.
      --
      -- In order to support defaulting to the Mason-installed Rust Analyzer
      -- and then being able to fall back to the system, this Mason-found-first
      -- path resolving logic needs to be overcome.
      require("mason-registry"):on(
        "package:install:success",
        vim.schedule_wrap(function(pkg, _)
          if pkg.name == "rust-analyzer" then
            local bin_symlink = vim.fs.joinpath(
              vim.fs.dirname(vim.fs.dirname(pkg:get_install_path())),
              "bin",
              "rust-analyzer"
            )
            if vim.fn.exists(bin_symlink) == 0 then
              vim.uv.fs_unlink(bin_symlink)
            end
          end
        end)
      )

      local lsps = require("my.mason.lsps")
      local lsps_manual = require("my.mason.lsps_manual")
      local all_lsp_servers = vim.tbl_deep_extend("error", {}, lsps.configuration, lsps_manual.configuration)

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

            -- Rust Analyzer is configured via `rustaceanvim` so the client's
            -- `setup` function should not be called.
            -- See `:help rustaceanvim.mason` for more details
            if server_name ~= "rust_analyzer" then
              require("lspconfig")[server_name].setup(server)
            end
          end,
        },
      })
    end,
  },
  -- Supercharge your Rust experience in Neovim!
  --
  -- https://github.com/mrcjkb/rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
      },
      server = {
        default_settings = rust_analyzer_settings,
      },
    },
    config = function(_, opts)
      local notify = require("my.util.notify")

      if opts.server ~= nil and opts.server.cmd ~= nil then
        notify.error("vim.g.rustaceanvim.server.cmd cannot be set via configuration")
        return
      end

      -- Find the full path to the `rust-analyzer` program in the Mason package
      local cmd_func = function()
        local binary = "rust-analyzer"
        local ra_path = binary

        -- Use an environment variable to force using a system version and not
        -- a Mason-installed version
        local use_local = os.getenv("NVIM_RUST_ANALYZER_LOCAL") ~= nil

        local has_mason, mason_registry = pcall(require, "mason-registry")
        if not use_local and has_mason and mason_registry.is_installed(binary) then
          local ra_package = mason_registry.get_package(binary)
          local ra_bin_candidates = vim.split(
            vim.fn.glob(vim.fs.joinpath(ra_package:get_install_path(), "rust-analyzer-*")),
            "\n",
            { trimempty = true }
          )
          if #ra_bin_candidates > 0 then
            ra_path = ra_bin_candidates[1]
          end
        end

        return { ra_path, "--log-file", vim.fn.tempname() .. "-rust-analyzer.log" }
      end

      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      vim.g.rustaceanvim =
        vim.tbl_deep_extend("error", vim.g.rustaceanvim, { server = { cmd = cmd_func } })

      local cmd_path = cmd_func()[1]
      if vim.fn.executable(cmd_path) == 1 then
        require("my.util.notify").trace(
          ("Found **rust-analyzer** binary: " .. vim.fn.exepath(cmd_path))
        )
      else
        require("my.util.notify").error(
          "**rust-analyzer** binary not found in PATH, please install it"
        )
      end
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
