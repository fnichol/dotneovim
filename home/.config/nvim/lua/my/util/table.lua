M = {}

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

M.filter_map = filter_map
M.filter_map_to_list = filter_map_to_list
M.filter_use_table = filter_use_table
M.filter_install_list = filter_install_list

return M
