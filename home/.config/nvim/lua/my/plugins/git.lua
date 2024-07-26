return {
  -- A Git wrapper so awesome, it should be illegal
  --
  -- https://github.com/tpope/vim-fugitive
  { "tpope/vim-fugitive" },
  -- Git integration for buffers
  --
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
}
