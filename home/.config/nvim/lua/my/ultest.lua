local require_or_warn = require("my.utils").require_or_warn

-- Usage: https://github.com/rcarriga/vim-ultest

vim.api.nvim_exec([[let test#rust#cargotest#options = "--color=always"]], false)
vim.api.nvim_exec([[let test#strategy = "neovim"]], false)

-- Schedules the detection execution to run on the event loop so as to not
-- block when this module is loaded in on boot
vim.defer_fn(require("my.install.pynvim").add_install_command_if_not_detected, 0)
