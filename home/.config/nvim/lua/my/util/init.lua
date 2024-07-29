M = {}

---Returns the name for the current Lua module.
---@param stack_level? number number of stack frames to remove to get the correct name
---@return string
M.modname = function(stack_level)
  local root = os.getenv("MYVIMRC"):gsub("init.lua$", "")
  local name, _ = debug
    .getinfo(stack_level or 2, "S").short_src
    :gsub("^" .. root .. "lua/", "")
    :gsub(".lua$", "")
    :gsub("/", ".")

  return name
end

return M
