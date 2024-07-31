return {
  -- Simple UI for vim-dadbod
  --
  -- https://github.com/kristijanhusak/vim-dadbod-ui
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      -- Modern database interface for Vim
      --
      -- https://github.com/tpope/vim-dadbod
      { "tpope/vim-dadbod", lazy = true },
      -- Database autocompletion powered by vim-dadbod
      --
      -- https://github.com/kristijanhusak/vim-dadbod-completion
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = {
          "mysql",
          "psql",
          "sql",
        },
      },
    },
    cmd = {
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIToggle",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
