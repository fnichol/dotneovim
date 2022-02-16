local require_or_warn = require("my.utils").require_or_warn

-- Usage: https://github.com/rcarriga/vim-ultest

vim.api.nvim_exec([[let test#rust#cargotest#options = "--color=always"]], false)
vim.api.nvim_exec([[let test#strategy = "neovim"]], false)
