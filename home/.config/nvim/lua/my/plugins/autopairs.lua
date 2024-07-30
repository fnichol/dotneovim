return {
  -- Autopairs for Neovim written in Lua
  --
  -- https://github.com/windwp/nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    depdendencies = {
      -- A completion plugin for NeoVim coded in Lua.
      --
      -- https://github.com/hrsh7th/nvim-cmp
      { "hrsh7th/nvim-cmp" },
    },
    config = function()
      require("nvim-autopairs").setup({})
      -- Integrate with `nvim-cmp`
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm.done", cmp_autopairs.on_confirm_done())
    end,
  },
}
