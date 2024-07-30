return {
  -- Delete buffers and close files in Vim without closing your windows or
  -- messing up your layout.
  --
  -- https://github.com/moll/vim-bbye
  {
    "moll/vim-bbye",
    keys = {
      { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
    },
  },
  -- A snazzy bufferline for Neovim
  --
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      -- Lua fork of vim-web-devicons for NeoVim
      --
      -- https://github.com/nvim-tree/nvim-web-devicons
      {
        "nvim-tree/nvim-web-devicons",
	enabled = vim.g.have_nerd_font,
      },
    },
    opts = {
      options = {
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
      },
    },
  },
}
