vim.opt_local.colorcolumn = "80"

local wk = require("which-key")
wk.add({
  { "<leader>m", group = "Markdown" },
})

vim.keymap.set("n", "<leader>ms", function()
  require("mdkite").start()
end, { desc = "Start preview" })

vim.keymap.set("n", "<leader>mS", function()
  require("mdkite").stop()
end, { desc = "Stop preview" })

vim.keymap.set("n", "<leader>mr", function()
  require("mdkite").refresh()
end, { desc = "Refresh preview" })
