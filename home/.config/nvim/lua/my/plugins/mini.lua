return {
  -- Library of 40+ independent Lua modules improving overall Neovim experience
  -- with minimal effort
  --
  -- https://github.com/echasnovski/mini.nvim
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Simple and easy statusline.
      local statusline = require("mini.statusline")
      -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })
    end,
  },
}
