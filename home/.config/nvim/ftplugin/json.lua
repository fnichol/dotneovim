local colorcolumn = 80
require("my.utils").setlocal_colorcolumn(colorcolumn)

-- Schedules the detection execution to run on the event loop so as to not
-- block when this module is loaded in on boot
vim.defer_fn(require("my.install.jsonlint").add_install_command_if_not_detected())
vim.defer_fn(require("my.install.prettier").add_install_command_if_not_detected())
