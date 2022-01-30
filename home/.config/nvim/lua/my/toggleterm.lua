local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  vim.notify("[my.toggleterm] failed to require 'toggleterm'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/akinsho/toggleterm.nvim

toggleterm.setup({
  -- Size can be a number or function which is passed to the current terminal
  size = 20,
  open_mapping = [[<C-\>]],
  -- Hides the number column in toggleterm buffers
  hide_numbers = true,
  shade_filetypes = {},
  -- The degress to which to darken to terminal color
  -- [default: 1 for dark backgrounds, 3 for light]
  shading_factor = 2,
  start_in_insert = true,
  -- Whether or not the open mapping applies in insert mode
  insert_mappings = true,
  persist_size = true,
  -- [default: vertical, horizontal, window, float]
  direction = "float",
  -- Closes the terminal window when the process exits [default: true]
  close_on_exit = true,
  -- Change the default shell
  shell = vim.o.shell,
  -- Option which is relevant if direction is set to 'float'
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

if vim.fn.executable("gitui") == 1 then
  local gitui = Terminal:new({ cmd = "gitui", hidden = true })

  function _GITUI_TOGGLE()
    gitui:toggle()
  end
else
  function _GITUI_TOGGLE()
    vim.notify("[my.toggleterm] missing required program 'gitui'", vim.log.levels.WARN)
  end
end

if vim.fn.executable("htop") == 1 then
  local htop = Terminal:new({ cmd = "htop", hidden = true })

  function _HTOP_TOGGLE()
    htop:toggle()
  end
else
  function _HTOP_TOGGLE()
    vim.notify("[my.toggleterm] missing required program 'htop'", vim.log.levels.WARN)
  end
end
