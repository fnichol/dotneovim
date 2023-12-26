local require_or_warn = require("my.utils").require_or_warn

local comment_ft_ok, comment_ft = require_or_warn("Comment.ft")
if not comment_ft_ok then
  return
end

-- Add support for HCL files
-- References: https://github.com/numToStr/Comment.nvim/issues/382
-- References: https://github.com/numToStr/Comment.nvim/pull/398
comment_ft.hcl = { '#%s', '/*%s*/' }

local ok, comment = require_or_warn("Comment")
if not ok then
  return
end

-- Usage: https://github.com/numToStr/Comment.nvim

comment.setup()
