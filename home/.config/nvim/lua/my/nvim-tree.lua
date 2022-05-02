-- Usage: https://github.com/kyazdani42/nvim-tree.lua
--
-- Each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

-- There is some kind of refactoring/migration going on in the upstream
-- project, so these Vim global settings are likely temporary and may return to
-- the `setup(...)` configuration at some point in the future. Maybe?
--
-- https://github.com/kyazdani42/nvim-tree.lua/issues/674
-- https://github.com/LunarVim/Neovim-from-scratch/issues/124

-- Enables file highlight for Git attributes
vim.g["nvim_tree_git_hl"] = 1
-- In what format to show root folder
vim.g["nvim_tree_root_folder_modifier"] = ":t"
-- Icons to render
vim.g["nvim_tree_show_icons"] = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
  tree_width = 30,
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
