local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
  return
end

-- Usage: https://github.com/xiyaowong/nvim-transparent

transparent.setup({
  enable = true,
})
