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
      {
        dir = vim.fs.joinpath(vim.fn.stdpath("data"), "my", "mason-lock.nvim"),
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
      require("mason").setup({
        -- Limit for the maximum amount of packages to be installed at the same
        -- time. Once this limit is reached, any further packages that are
        -- requested to be installed will be put in a queue.
        max_concurrent_installers = 4,
        firewall = {
          -- Enable the socket.dev firewall (sfw) for supported packages
          enabled = true,
        },
      })

      local lock = require("mason-lock")
      local ensure_installed_list = require("my.util.mason").ensure_installed_list()

      if lock.lockfile_exists() then
        -- Set `ensure_installed` so later calls to mason-tool-installer will have populated list
        require("mason-tool-installer").setup({
          ensure_installed = ensure_installed_list,
          run_on_start = false,
        })
        -- Install or update packages using lockfile
        require("mason-lock").restore(ensure_installed_list, { verbose = false })
      else
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed_list })
      end
    end,
  },
}
