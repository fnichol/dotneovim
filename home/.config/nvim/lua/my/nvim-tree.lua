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

local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  vim.notify("[my.nvim-tree] failed to require 'nvim-tree'", vim.log.levels.WARN)
  return
end

local config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_ok then
  vim.notify("[my.nvim-tree] failed to require 'nvim-tree.config'", vim.log.levels.WARN)
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
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
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, action = "edit" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
      },
    },
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
