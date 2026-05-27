M = {}

local on_openbsd = function()
  return vim.uv.os_uname().sysname == "OpenBSD"
end

local has_executable = function(executable)
  return vim.fn.executable(executable) == 1
end

M.on_openbsd = on_openbsd
M.has_executable = has_executable

return M
