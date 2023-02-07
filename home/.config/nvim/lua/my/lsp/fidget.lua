local ok, fidget = pcall(require, "fidget")
if not ok then
  vim.notify("[my.fidget] failed to require 'fidget'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/j-hui/fidget.nvim

fidget.setup({})
