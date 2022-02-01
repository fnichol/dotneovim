local ok, lightbulb = pcall(require, "nvim-lightbulb")
if not ok then
  vim.notify("[my.lightbulb] failed to require 'nvim-lightbulb'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/kosayoda/nvim-lightbulb

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
