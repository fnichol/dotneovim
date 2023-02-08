local require_or_warn = require("my.utils").require_or_warn

local neotest_ok, neotest = require_or_warn("neotest")
if not neotest_ok then
  return
end

-- Usage: https://github.com/nvim-neotest/neotest

neotest.setup({
  adapters = {
    require("neotest-rust"),
  },
})
