local ok, ibl = pcall(require, "ibl")
if not ok then
  vim.notify("[my.indentline] failed to require 'indent_blankline'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/lukas-reineke/indent-blankline.nvim

-- Adds a listchars for trailing whitespace
vim.opt.list = true
vim.opt.listchars:append("trail:⋅")

ibl.setup()
