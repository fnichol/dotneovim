M = {}

---Returns a new table that is filtered then mapped.
---@generic K1: unknown
---@generic K2: unknown
---@generic V1: unknown
---@generic V2: unknown
---@param tbl table<K1, V1>
---@param filter_fn fun(key: K1, val: V1): boolean
---@param map_fn fun(key: K1, val: V1): K2, V2
---@return table<K2, V2>
local filter_map = function(tbl, filter_fn, map_fn)
  local result = {}

  for key, val in pairs(tbl) do
    if filter_fn(key, val) then
      local mapped_key, mapped_val = map_fn(key, val)

      result[mapped_key] = mapped_val
    end
  end

  return result
end
M.filter_map = filter_map

---Returns a new list that is filtered then mapped.
---@generic K: unknown
---@generic V: unknown
---@generic R: unknown
---@param tbl table<K, V>
---@param filter_fn fun(key: K, val: V): boolean
---@param map_fn fun(key: K, val: V): R
---@return R[]
local filter_map_to_list = function(tbl, filter_fn, map_fn)
  local result = {}

  for key, val in pairs(tbl) do
    if filter_fn(key, val) then
      local element = map_fn(key, val)

      table.insert(result, element)
    end
  end

  return result
end
M.filter_map_to_list = filter_map_to_list

---Returns a new list that is mapped from the given table.
---@generic K: unknown
---@generic V: unknown
---@generic R: unknown
---@param tbl table<K, V>
---@param map_fn fun(key: K, val: V): R
---@return R[]
local map_to_list = function(tbl, map_fn)
  local result = {}

  for key, val in pairs(tbl) do
    local element = map_fn(key, val)
    table.insert(result, element)
  end

  return result
end
M.map_to_list = map_to_list

---Returns a new table which rejects values containing condition functions
---that return `false`.
---@param tbl table<unknown, unknown>
---@return table<unknown, unknown>
local filter_use_table = function(tbl)
  return filter_map(tbl, function(_, val)
    if val["install_and_use_condition"] ~= nil then
      return val["install_and_use_condition"]()
    elseif val["use_condition"] ~= nil then
      return val["use_condition"]()
    else
      return true
    end
  end, function(key, val)
    local new_val = vim.deepcopy(val)
    new_val["install_and_use_condition"] = nil
    new_val["install_condition"] = nil
    new_val["use_condition"] = nil
    return key, new_val
  end)
end
M.filter_use_table = filter_use_table

---Returns a new lst which rejects values containing condition functions that
---return `false`.
---@param tbl table<unknown, unknown>
---@return unknown[]
local filter_install_list = function(tbl)
  return filter_map_to_list(tbl, function(_, val)
    if val["install_and_use_condition"] ~= nil then
      return val["install_and_use_condition"]()
    elseif val["install_condition"] ~= nil then
      return val["install_condition"]()
    else
      return true
    end
  end, function(key, _)
    return key
  end)
end
M.filter_install_list = filter_install_list

return M
