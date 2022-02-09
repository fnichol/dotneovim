local require_or_warn = require("my.utils").require_or_warn

local ok, octo = require_or_warn("octo")
if not ok then
  return
end

-- Usage: https://github.com/pwntester/octo.nvim

octo.setup()
