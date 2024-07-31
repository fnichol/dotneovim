return {
  -- Highlight, list and search todo comments in your projects
  --
  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = {
      -- full; complete; entire; absolute; unqualified. All the lua functions I
      -- don't want to write twice.
      --
      -- https://github.com/nvim-lua/plenary.nvim
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      signs = false,
    },
    cmd = { "TodoTrouble", "TodoTelescope" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      {
        "<leader>sT",
        "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>",
        desc = "Search Todo/Fix/Fixme",
      },
    },
  },
}
