local colorcolumn = 80
require("my.utils").setlocal_colorcolumn(colorcolumn)

require("my.install.jsonlint").add_install_command_if_not_detected()
require("my.install.prettier").add_install_command_if_not_detected()
