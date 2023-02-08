local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

-- https://github.com/rust-dev-tools/fmt-rfcs/blob/master/guide/guide.md
local colorcolumn = 100
utils.setlocal_colorcolumn(colorcolumn)
