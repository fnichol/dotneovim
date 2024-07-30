return {
  -- Soothing pastel theme for (Neo)vim
  --
  -- https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Ensure this plugin loads before all other start plugins
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  -- Remove all background colors to make nvim transparent
  --
  -- https://github.com/xiyaowong/transparent.nvim
  {
    "xiyaowong/nvim-transparent",
    lazy = false,
    opts = {},
  },
}
