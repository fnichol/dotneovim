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

      local lsps = require("my.mason.lsps").install()
      local mason_install_only_lsps = require("my.mason.lsps_install_only").install()
      local formatters = require("my.mason.formatters").install()
      local linters = require("my.mason.linters").install()
      local daps = require("my.mason.daps").install()

      -- You can add other tools here that you want Mason to install for you,
      -- so that they are available from within Neovim.
      local ensure_installed = lsps or {}
      vim.list_extend(ensure_installed, mason_install_only_lsps or {})
      vim.list_extend(ensure_installed, formatters or {})
      vim.list_extend(ensure_installed, linters or {})
      vim.list_extend(ensure_installed, daps or {})

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
    end,
  },
}
