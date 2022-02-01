local ok, notify = pcall(require, "notify")
if not ok then
  vim.notify("[my.notify] failed to require 'notify'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/rcarriga/nvim-notify

notify.setup({
  background_colour = "#000000",
})

vim.notify = notify
