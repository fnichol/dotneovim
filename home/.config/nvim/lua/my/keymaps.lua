--  See `:help vim.keymap.set()`

-- Clear highlight on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tab switch buffer
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Go to the previous buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Go to the next buffer" })

-- Resize with arrows
if vim.fn.has("mac") == 1 then
  -- On macOS, map normal mode window resizing keys to (<A-<arrows>)
  vim.keymap.set("n", "<A-Up>", ":resize -2<CR>", { desc = "Resize window up" })
  vim.keymap.set("n", "<A-Down>", ":resize +2<CR>", { desc = "Resize window down" })
  vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
  vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })
else
  -- All other systems, map normal mode window resizing keys to (<C-<arrows>)
  vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
  vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
  vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
  vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })
end

-- Preserve selection after indentation
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Map tab/shift-tab to indent
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Autocmd to restore previous cursor position, if known.
--
-- See: https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})
