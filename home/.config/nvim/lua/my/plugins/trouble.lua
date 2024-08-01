return {
  -- A pretty diagnostics, references, telescope results, quickfix and location
  -- list to help you solve all the trouble your code is causing.
  --
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      {
        "<leader>rl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        "LSP refs/defs/... (Trouble)",
      },
      {
        "<leader>rL",
        "<cmd>Trouble loclist toggle<CR>",
        "Location List (Trouble)",
      },
      {
        "<leader>rq",
        "<cmd>Trouble qflist toggle<CR>",
        "Quickfix List (Trouble)",
      },
      {
        "<leader>rs",
        "<cmd>Trouble symbols toggle focus=false<CR>",
        "Symbols (Trouble)",
      },
      {
        "<leader>rx",
        "<cmd>Trouble diagnostics toggle<CR>",
        "Diagnostics (Trouble)",
      },
      {
        "<leader>rX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        "Buffer Diagnostics (Trouble)",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
}
