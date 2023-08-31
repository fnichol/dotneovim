-- Usage: https://github.com/kyazdani42/nvim-tree.lua

-- Configuration options for icon glyphs (see: `:help nvim-tree.renderer.icons.glyphs`)
local renderer_icons_glyphs = {
  -- Glyph for files
  default = "",
  -- Glyph for symlink to files
  symlink = "",
  -- Glyphs for Git status
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  -- Glyphs for directories
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local require_or_warn = require("my.utils").require_or_warn

local nvim_tree_ok, nvim_tree = require_or_warn("nvim-tree")
if not nvim_tree_ok then
  return
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

nvim_tree.setup({
  on_attach = on_attach,
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    number = false,
    relativenumber = false,
  },
  renderer = {
    -- Enables file highlight for Git attributes
    highlight_git = true,
    -- In what format to show root folder
    root_folder_modifier = ":t",
    icons = {
      -- Icons to render
      show = {
        git = true,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = renderer_icons_glyphs,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    open_file = {
      -- Closes the tree when you open a file
      quit_on_open = true,
    },
  },
})
