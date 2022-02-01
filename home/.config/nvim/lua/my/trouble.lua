local ok, trouble = pcall(require, "trouble")
if not ok then
  vim.notify("[my.trouble] failed to require 'trouble'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/folke/trouble.nvim

trouble.setup({})
