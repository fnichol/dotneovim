return {
  -- Install and upgrade third party tools automatically
  --
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      -- Portable package manager for Neovim that runs everywhere Neovim runs.
      --
      -- https://github.com/mason-org/mason.nvim
      {
        "mason-org/mason.nvim",
        -- NOTE: Must be loaded before dependants
        config = true,
      },
      -- Lockfile suppport for mason.nvim
      --
      -- https://github.com/zapling/mason-lock.nvim
      {
        "zapling/mason-lock.nvim",
        config = true,
      },
      { "mason-org/mason-lspconfig.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    config = function()
      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run `:Mason`
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()

      local ensure_installed = require("my.util.mason").ensure_installed_list()

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    end,
  },
}
