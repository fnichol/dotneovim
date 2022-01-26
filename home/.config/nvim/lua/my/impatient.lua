local ok, impatient = pcall(require, "impatient")
if not ok then
  vim.notify("[my.impatient] failed to require 'impatient'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/lewis6991/impatient.nvim

impatient.enable_profile()
