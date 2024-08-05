return {
  -- Lightweight yet powerful formatter plugin for Neovim
  --
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
    },
    config = function(_, opts)
      local formatters = require("my.mason.formatters")
      local formatters_manual = require("my.mason.formatters_manual")

      local all_formatters =
        vim.tbl_deep_extend("error", {}, formatters.configuration, formatters_manual.configuration)
      local all_by_filetypes =
        vim.tbl_deep_extend("error", {}, formatters.by_filetype, formatters_manual.by_filetype)

      opts.formatters_by_ft = all_by_filetypes
      opts.formatters = all_formatters

      require("conform").setup(opts)
    end,
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
  },
}
