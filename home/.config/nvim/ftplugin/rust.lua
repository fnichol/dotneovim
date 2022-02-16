local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

-- https://github.com/rust-dev-tools/fmt-rfcs/blob/master/guide/guide.md
local colorcolumn = 100
utils.setlocal_colorcolumn(colorcolumn)

local ok, which_key = require_or_warn("which-key")
if not ok then
  return
end

which_key.register({
  C = {
    "<cmd>lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>",
    "Open Cargo.toml",
  },
  p = {
    "<cmd>lua require('rust-tools.parent_module').parent_module()<CR>",
    "Goto Parent Module",
  },
}, { buffer = 0, prefix = "g" })

which_key.register({
  R = {
    name = "Rust",
    h = { "<cmd>lua require('rust-tools.hover_actions').hover_actions()<CR>", "Hover Actions" },
    H = {
      "<cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>",
      "Toggle Inlay Hints",
    },
    m = { "<cmd>lua require('rust-tools.expand_macro').expand_macro()<CR>", "Expand Macro" },
    R = { "<cmd>lua require('rust-tools.runnables').runnables()<CR>", "Runnables" },
  },
}, { buffer = 0, prefix = "<leader>" })
