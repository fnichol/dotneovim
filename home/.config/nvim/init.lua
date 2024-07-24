-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require("my.options")

-- [[ Basic Keymaps ]]
require("my.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("my.lazy")

-- [[ Configure and install plugins ]]
require("my.plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
