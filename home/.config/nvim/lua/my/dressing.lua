local ok, dressing = pcall(require, "dressing")
if not ok then
  vim.notify("[my.dressing] failed to require 'dressing'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/stevearc/dressing.nvim

dressing.setup({
  input = {
    winblend = 0,
  },
})
