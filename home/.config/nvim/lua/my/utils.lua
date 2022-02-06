M = {}

M.setlocal_colorcolumn = function(width)
  vim.api.nvim_exec(string.format("setlocal colorcolumn=%d", width), false)
end

return M
