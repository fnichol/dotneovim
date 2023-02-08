local require_or_warn = require("my.utils").require_or_warn

local ok, comment = require_or_warn("Comment")
if not ok then
  return
end

-- Usage: https://github.com/numToStr/Comment.nvim

comment.setup()
