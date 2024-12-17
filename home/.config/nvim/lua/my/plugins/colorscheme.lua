local default_colorscheme = "catppuccin-macchiato"

return {
  -- Fake directory plugin to contain all colorscheme plugins and trigger the
  -- current colorscheme
  {
    "my-colorschemes",
    virtual = true,
    dependencies = {
      -- Soothing pastel theme for (Neo)vim
      --
      -- https://github.com/catppuccin/nvim
      {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000, -- Ensure this plugin loads before all other start plugins
      },
      -- A clean, dark Neovim theme written in Lua, with support for lsp,
      -- treesitter and lots of plugins. Includes additional themes for Kitty,
      -- Alacritty, iTerm and Fish
      --
      -- https://github.com/folke/tokyonight.nvim
      {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000, -- Ensure this plugin loads before all other start plugins
        opts = {},
      },
      -- A dark, low-contrast, Vim colorscheme.
      --
      -- https://github.com/romainl/Apprentice
      {
        "romainl/Apprentice",
        lazy = false,
        priority = 1000, -- Ensure this plugin loads before all other start plugins
      },
    },
    lazy = false,
    priority = 1000, -- Ensure this plugin loads before all other start plugins
    init = function()
      vim.cmd.colorscheme(default_colorscheme)
    end,
  },
  -- Remove all background colors to make nvim transparent
  --
  -- https://github.com/xiyaowong/transparent.nvim
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    opts = {},
    init = function() end,
  },
}
