return {
  -- Create key bindings that stick.
  --
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "echasnovski/mini.icons" },
    },
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")

      wk.setup({})

      wk.add({
        { "<leader>g", group = "Git" },
        { "<leader>i", group = "Installers" },
        { "<leader>l", group = "LSP" },
        { "<leader>il", group = "Lazy" },
        { "<leader>s", group = "Search" },
        { "<leader>w", group = "VimWiki" },
      })
    end,
  },
}
