return {
  -- Neovim plugin to manage the file system and other tree like structures
  --
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      -- full; complete; entire; absolute; unqualified. All the lua functions I
      -- don't want to write twice.
      --
      -- https://github.com/nvim-lua/plenary.nvim
      { "nvim-lua/plenary.nvim" },
      -- Lua fork of vim-web-devicons for NeoVim
      --
      -- https://github.com/nvim-tree/nvim-web-devicons
      {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.have_nerd_font,
      },
      -- UI Component Library for Neovim
      --
      -- https://github.com/MunifTanjim/nui.nvim
      { "MunifTanjim/nui.nvim" },
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true,
        },
        window = {
          mappings = {
            ["<leader>e"] = "close_window",
          },
        },
      },
    },
  },
}
