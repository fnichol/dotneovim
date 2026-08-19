return {
  -- Live Markdown preview for Neovim.
  --
  -- https://github.com/selimacerbas/markdown-preview.nvim
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = {
      -- A tiny, zero-dependency local web server for Neovim.
      --
      -- https://github.com/selimacerbas/live-server.nvim
      { "selimacerbas/live-server.nvim" },
    },
    config = function()
      require("markdown_preview").setup({
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
