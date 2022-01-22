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
end
