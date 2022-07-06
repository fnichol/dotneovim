-- Usage: https://github.com/rcarriga/vim-ultest

-- Set a reminder to check the state of https://github.com/nvim-neotest/neotest
-- for Rust/Cargo compatibility.
if os.time() < os.time({ year = 2022, month = 8, day = 1 }) then
  vim.g.ultest_deprecation_notice = 0
end

vim.api.nvim_exec([[let test#rust#cargotest#options = "--color=always"]], false)
vim.api.nvim_exec([[let test#strategy = "neovim"]], false)

-- Schedules the detection execution to run on the event loop so as to not
-- block when this module is loaded in on boot
vim.defer_fn(require("my.install.pynvim").add_install_command_if_not_detected, 0)
