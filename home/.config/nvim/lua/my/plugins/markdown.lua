return {
  -- Live Markdown preview for Neovim.
  --
  -- https://github.com/selimacerbas/mdkite.nvim
  {
    "selimacerbas/mdkite.nvim",
    dependencies = {
      -- A tiny, zero-dependency local web server for Neovim.
      --
      -- https://github.com/selimacerbas/kitehost.nvim
      { "selimacerbas/kitehost.nvim" },
    },
    config = function()
      require("mdkite").setup({
        default_theme = "light",
        hooks = {
          on_start = function(url)
            vim.notify("Preview started: " .. url, vim.log.levels.INFO)
          end,
        },
      })
    end,
  },
}
