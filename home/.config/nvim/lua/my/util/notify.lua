M = {}

M._notify = function(log_level, stack_level, msg, ...)
  vim.notify(
    string.format("[%s] %s", require("my.util").modname(stack_level), string.format(msg, ...)),
    log_level
  )
end

---Notifies a message at the `DEBUG` level
---@param msg string notification message
---@param ... unknown arguments for `string.format()`
M.debug = function(msg, ...)
  M._notify(vim.log.levels.DEBUG, 4, msg, ...)
end

---Notifies a message at the `ERROR` level
---@param msg string notification message
---@param ... unknown arguments for `string.format()`
M.error = function(msg, ...)
  M._notify(vim.log.levels.ERROR, 4, msg, ...)
end

---Notifies a message at the `INFO` level
---@param msg string notification message
---@param ... unknown arguments for `string.format()`
M.info = function(msg, ...)
  M._notify(vim.log.levels.INFO, 4, msg, ...)
end

---Notifies a message at the `TRACE` level
---@param msg string notification message
---@param ... unknown arguments for `string.format()`
M.trace = function(msg, ...)
  M._notify(vim.log.levels.TRACE, 4, msg, ...)
end

---Notifies a message at the `WARN` level
---@param msg string notification message
---@param ... unknown arguments for `string.format()`
M.warn = function(msg, ...)
  M._notify(vim.log.levels.WARN, 4, msg, ...)
end

return M
