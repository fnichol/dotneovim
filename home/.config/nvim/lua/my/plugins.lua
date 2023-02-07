return function(use)
  -- Packer manages itself
  use("wbthomason/packer.nvim")
  -- An implementation of the Popup API from Vim in NeoVim
  use("nvim-lua/popup.nvim")
  -- Useful Lua functions used by many plugins
  use("nvim-lua/plenary.nvim")

  --
  -- ## Color schemes
  --
  -- Neovim plugin for building base16 colorschemes with support for Neovim's
  -- builtin LSP and Treesitter
  use("RRethy/nvim-base16")
  -- Remove all background colors to make nvim transparent
  use("xiyaowong/nvim-transparent")

  --
  -- ## Completions
  --
  -- A completion plugin for NeoVim coded in Lua.
  use({ "hrsh7th/nvim-cmp", requires = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" } })
  -- nvim-cmp source for NeoVim builtin LSP client
  use("hrsh7th/cmp-nvim-lsp")
  -- nvim-cmp source for buffer words
  use("hrsh7th/cmp-buffer")
  -- nvim-cmp source for path
  use("hrsh7th/cmp-path")
  -- nvim-cmp source for Vim's cmdline
  use("hrsh7th/cmp-cmdline")
  -- nvim-cmp source for NeoVim Lua
  use("hrsh7th/cmp-nvim-lua")
  -- nvim-cmp source for LuaSnip snippets
  use("saadparwaiz1/cmp_luasnip")
  -- Visual Studio Code-like pictograms for NeoVim LSP completion items
  use("onsails/lspkind-nvim")

  --
  -- ## Snippets
  --
  -- Snippet Engine for Neovim written in Lua
  use("L3MON4D3/LuaSnip")
  -- Set of preconfigured snippets for different languages
  use("rafamadriz/friendly-snippets")

  --
  -- ## Langugage Server Protocol (LSP)
  --
  -- A collection of common configurations for Neovim's built-in LSP client
  use("neovim/nvim-lspconfig")
  -- Configures Neovim LSP using JSON files like `coc-settings.json`
  use("tamago324/nlsp-settings.nvim")
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters
  use({ "williamboman/mason.nvim" })
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
  use({ "williamboman/mason-lspconfig.nvim", requires = { "neovim/nvim-lspconfig" } })
  -- Use NeoVim as a language server to inject LSP diagnostics, code actions, and more
  use("jose-elias-alvarez/null-ls.nvim")
  -- LSP signature hint as you type
  use("ray-x/lsp_signature.nvim")
  -- Fixes CursorHold Performance (This is needed to fix LSP doc highlight)
  use("antoinemadec/FixCursorHold.nvim")
  -- Standalone UI for nvim-lsp progress, eye candy for the impatient
  use("j-hui/fidget.nvim")
  -- Extra Rust tools for writing applications in NeoVim using the native LSP
  use({
    "simrat39/rust-tools.nvim",
    requires = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
  })

  --
  -- ## Debugging and Debuggers
  --
  -- A NeoVim plugin for managing several debuggers for nvim-dap
  --
  -- TODO: It appears that the author of DAPInstall.nvim is rewriting this
  -- plugin, but using the same repository on the main branch. As a result,
  -- we'll pin to the last commit of `DAPInstall` as we wait for `dap-buddy` to
  -- mature.
  --
  use({ "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" })
  -- A UI for nvim-dap which provides a good out of the box configuration
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  --
  -- ## Debugging and Debuggers
  --
  -- The ultimate testing plugin for (Neo)Vim
  use({ "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" })

  --
  -- ## Fuzzy Finding, File Exploration, and Project Management
  --
  -- A highly extendable fuzzy finder over lists
  use("nvim-telescope/telescope.nvim")
  -- It sets vim.ui.select to telescope
  use("nvim-telescope/telescope-ui-select.nvim")
  -- FZF sorter for telescope written in C
  local telescope_fzf_native_build = "make"
  if vim.loop.os_uname().sysname == "OpenBSD" then
    telescope_fzf_native_build = "gmake"
  end
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = telescope_fzf_native_build })
  -- A file explorer tree for NeoVim written in Lua
  use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } })
  -- GitHub in NeoVim
  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  })

  --
  -- ## Treesitter
  --
  -- NeoVim Treesitter configurations and abstraction layer
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- NeoVim Treesitter plugin which sets the commentstring based on the cursor location
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Speeds up loading Lua modules in Neovim to improve startup time
  use("lewis6991/impatient.nvim")
  -- A fast and fully customizable greeter for NeoVim
  use({ "goolord/alpha-nvim", requires = { "kyazdani42/nvim-web-devicons" } })

  --
  -- ## Key Bindings and Documentation
  --
  -- Create key bindings that stick
  use("folke/which-key.nvim")

  --
  -- ## Formatting and Display
  --
  -- EditorConfig plugin for Vim
  use("editorconfig/editorconfig-vim")
  -- Autopair plugin for NeoVim that supports multiple characters
  use("windwp/nvim-autopairs")
  -- Smart and Powerful commenting plugin for NeoVim
  use("numToStr/Comment.nvim")
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use("tpope/vim-surround")
  -- Indent guides for Neovim
  use("lukas-reineke/indent-blankline.nvim")
  -- Highlights trailing whitespace in red
  use("bronson/vim-trailing-whitespace")
  -- NeoVim plugin to improve the default vim.ui interfaces
  use("stevearc/dressing.nvim")
  -- A fancy, configurable, notification manager for NeoVim
  use("rcarriga/nvim-notify")
  -- Git integration for buffers
  use("lewis6991/gitsigns.nvim")
  -- VSCode lightbulb for NeoVim's builtin LSP
  use("kosayoda/nvim-lightbulb")
  -- A pretty diagnostics, references, telescope results, quickfix and location
  -- list to help you solve all the trouble your code is causing
  use({ "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  -- A snazzy bufferline for NeoVim
  use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = { "kyazdani42/nvim-web-devicons" } })
  -- Allows you to do delete buffers (close files) without closing your windows
  -- or messing up your layout
  use("moll/vim-bbye")
  -- Plugin for automatically highlighting other uses of the word under the
  -- cursor using either LSP, Tree-sitter, or regex matching
  use("RRethy/vim-illuminate")
  -- An asynchronous markdown preview plugin for Vim and Neovim
  if vim.fn.executable("cargo") == 1 then
    use({ "euclio/vim-markdown-composer", run = "cargo build --release --locked" })
  end

  --
  -- ## System Integrations
  --
  -- Persists and toggles multiple terminals during an editing session
  use("akinsho/toggleterm.nvim")
  -- Fugitive is the premier Vim plugin for Git
  use("tpope/vim-fugitive")
  -- Modern database interface for Vim
  use("tpope/vim-dadbod")
  -- Simple UI for vim-dadbod
  use("kristijanhusak/vim-dadbod-ui")
  -- Database autocompletion powered by vim-dadbod
  use("kristijanhusak/vim-dadbod-completion")
  -- Personal wiki for Vim
  use({ "vimwiki/vimwiki", branch = "dev" })
end
