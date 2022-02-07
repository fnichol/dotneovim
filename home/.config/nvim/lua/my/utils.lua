M = {}

---Sets the `colorcolumn` for the local buffer
---
---@param width number
M.setlocal_colorcolumn = function(width)
  vim.api.nvim_exec(string.format("setlocal colorcolumn=%d", width), false)
end

---Requires a Lua module with a `pcall` and warns if the require failed.
---
---@param modname string
---@return boolean success
---@return any result
---@return ...
M.require_or_warn = function(modname)
  local ok, result = pcall(require, modname)
  if not ok then
    require("my.utils")._notify(vim.log.levels.WARN, 4, "failed to require '%s'", modname)
  end
  return ok, result
end

---Returns the name for the current Lua module.
---
---@param stack_level? number number of stack frames to remove to get the correct name
---@return string
M.modname = function(stack_level)
  local root = os.getenv("MYVIMRC"):gsub("init.lua$", "")
  local name, _ = debug.getinfo(stack_level or 2, "S").short_src
    :gsub("^" .. root .. "lua/", "")
    :gsub(".lua$", "")
    :gsub("/", ".")
  return name
end

M._notify = function(log_level, stack_level, msg, ...)
  vim.notify(
    string.format("[%s] %s", require("my.utils").modname(stack_level), string.format(msg, ...)),
    log_level
  )
end

M.notify = {
  ---Notifies a message at the `DEBUG` level
  ---
  ---@param msg string notification message
  ---@param ... any arguments for `string.format()`
  debug = function(msg, ...)
    require("my.utils")._notify(vim.log.levels.DEBUG, 4, msg, ...)
  end,
  ---Notifies a message at the `ERROR` level
  ---
  ---@param msg string notification message
  ---@param ... any arguments for `string.format()`
  error = function(msg, ...)
    require("my.utils")._notify(vim.log.levels.ERROR, 4, msg, ...)
  end,
  ---Notifies a message at the `INFO` level
  ---
  ---@param msg string notification message
  ---@param ... any arguments for `string.format()`
  info = function(msg, ...)
    require("my.utils")._notify(vim.log.levels.INFO, 4, msg, ...)
  end,
  ---Notifies a message at the `TRACE` level
  ---
  ---@param msg string notification message
  ---@param ... any arguments for `string.format()`
  trace = function(msg, ...)
    require("my.utils")._notify(vim.log.levels.TRACE, 4, msg, ...)
  end,
  ---Notifies a message at the `WARN` level
  ---
  ---@param msg string notification message
  ---@param ... any arguments for `string.format()`
  warn = function(msg, ...)
    require("my.utils")._notify(vim.log.levels.WARN, 4, msg, ...)
  end,
}

return M
