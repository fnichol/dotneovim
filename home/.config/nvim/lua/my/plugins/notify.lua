return {
  -- A fancy, configurable, notification manager for NeoVim
  --
  -- https://github.com/rcarriga/nvim-notify
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")

      notify.setup({
        background_colour = "#000000",
      })

      vim.notify = notify
    end,
  },
}
