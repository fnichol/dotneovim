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
  -- Companion nvim-lspconfig which installs LSP servers locally
  use({ "williamboman/nvim-lsp-installer", requires = { "neovim/nvim-lspconfig" } })
  -- Use NeoVim as a language server to inject LSP diagnostics, code actions, and more
  use("jose-elias-alvarez/null-ls.nvim")

  --
  -- ## Fuzzy Finding
  --
  -- A highly extendable fuzzy finder over lists
  use("nvim-telescope/telescope.nvim")
  -- It sets vim.ui.select to telescope
  use("nvim-telescope/telescope-ui-select.nvim")
  -- FZF sorter for telescope written in C
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  --
  -- ## Treesitter
  --
  -- NeoVim Treesitter configurations and abstraction layer
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- NeoVim Treesitter plugin which sets the commentstring based on the cursor location
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Autopair plugin for NeoVim that supports multiple characters
  use("windwp/nvim-autopairs")
  -- Smart and Powerful commenting plugin for NeoVim
  use("numToStr/Comment.nvim")
  -- Create key bindings that stick
  use("folke/which-key.nvim")
end
