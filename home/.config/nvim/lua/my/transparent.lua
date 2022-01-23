local ok, transparent = pcall(require, "transparent")
if not ok then
  vim.notify("[my.transparent] failed to require 'transparent'", WARN)
  return
end

-- Usage: https://github.com/xiyaowong/nvim-transparent

transparent.setup({
  enable = true,
})
