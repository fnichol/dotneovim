M = {}

local configuration = {}

local by_filetype = {}

local table = require("my.util.table")

M.configuration = function()
  return table.filter_use_table(configuration)
end
M.by_filetype = function()
  return table.filter_use_table(by_filetype)
end

return M
