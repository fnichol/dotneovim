return function(use)
  -- Packer manages itself
  use "wbthomason/packer.nvim"
  -- An implementation of the Popup API from Vim in NeoVim
  use "nvim-lua/popup.nvim"
  -- Useful Lua functions used by many plugins
  use "nvim-lua/plenary.nvim"

  --
  -- ## Color schemes
  --
  -- Neovim plugin for building base16 colorschemes with support for Neovim's
  -- builtin LSP and Treesitter
  use "RRethy/nvim-base16"
  -- Remove all background colors to make nvim transparent
  use "xiyaowong/nvim-transparent"

  --
  -- ## Completions
  --
  -- A completion plugin for NeoVim coded in Lua.
  use { "hrsh7th/nvim-cmp", requires = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" } }
  -- nvim-cmp source for buffer words
  use "hrsh7th/cmp-buffer"
  -- nvim-cmp source for path
  use "hrsh7th/cmp-path"
  -- nvim-cmp source for Vim's cmdline
  use "hrsh7th/cmp-cmdline"
  -- nvim-cmp source for NeoVim Lua
  use "hrsh7th/cmp-nvim-lua"
  -- nvim-cmp source for LuaSnip snippets
  use "saadparwaiz1/cmp_luasnip"
  -- Visual Studio Code-like pictograms for NeoVim LSP completion items
  use "onsails/lspkind-nvim"

  --
  -- ## Snippets
  --
  -- Snippet Engine for Neovim written in Lua
  use "L3MON4D3/LuaSnip"
  -- Set of preconfigured snippets for different languages
  use "rafamadriz/friendly-snippets"
end
