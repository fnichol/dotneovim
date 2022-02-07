local colorcolumn = 80
require("my.utils").setlocal_colorcolumn(colorcolumn)

vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

require("my.install.yamllint").add_install_command_if_not_detected()
