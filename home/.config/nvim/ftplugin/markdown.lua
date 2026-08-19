vim.opt_local.colorcolumn = "80"

local wk = require("which-key")
wk.add({
  { "<leader>m", group = "Markdown" },
})

vim.keymap.set("n", "<leader>ms", function()
  require("markdown_preview").start()
end, { desc = "Start preview" })

vim.keymap.set("n", "<leader>mS", function()
  require("markdown_preview").stop()
end, { desc = "Stop preview" })

vim.keymap.set("n", "<leader>mr", function()
  require("markdown_preview").refresh()
end, { desc = "Refresh preview" })
