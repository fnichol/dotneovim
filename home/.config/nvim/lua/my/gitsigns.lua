local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  vim.notify("[my.gitsigns] failed to require 'gitsigns'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/lewis6991/gitsigns.nvim

local config = {
  signs = {
    add = {
      text = "│",
    },
    change = {
      text = "│",
    },
    delete = {
      text = "契",
    },
    topdelete = {
      text = "契",
    },
    changedelete = {
      text = "│",
    },
  },
  -- Enables symbols in the sign column (toggle with `:Gitsigns toggle_signs`)
  -- [default: true]
  signcolumn = true,
  -- Enables line number highlights (toggle with `:Gitsigns toggle_numhl`)
  -- [default: false]
  numhl = false,
  -- Enables line highlights (toggle with `:Gitsigns toggle_linehl`)
  -- [default: false]
  linehl = false,
  -- Highlights intra-word differences (toggle with `:Gitsigns
  -- toggle_word_diff`) [default: false]
  word_diff = false,
  -- Detects when changes happen to use as a trigger to update signs
  watch_gitdir = {
    -- Interval in milliseconds for watcher to wait between polls
    -- [default: 1000]
    interval = 1000,
    -- Swith to new buffer location if `git mv` is used [default: true]
    follow_files = true,
  },
  -- Attaches to untracked files [default: true]
  attach_to_untracked = true,
  -- Adds an unobtrusive and customizable blame annotation at the end of the
  -- current line (toggle with `:Gitsigns toggle_current_line_blame`)
  -- [default: false]
  current_line_blame = false,
  -- Options for current_blame_line annotation
  current_line_blame_opts = {
    -- Shows a virtual text blame annotation [default: true]
    virt_text = true,
    -- Position for blame annotation [values: eol, overlay, right_align]
    -- [default: eol]
    virt_text_pos = "eol",
    -- Delay in milliseconds before blame virtual text is displayed
    -- [default: 1000]
    delay = 1000,
    -- Ignores whitespace when running blame
    ignore_whitespace = false,
  },
  -- Priority to use for signs [default: 6]
  sign_priority = 6,
  -- Debounce time in milliseconds for updates [default: 100]
  update_debounce = 100,
  -- Function used to format status [default: nil]
  status_formatter = nil, -- Use default
  -- Max file length to attach to [default: 4000]
  max_file_length = 40000,
  -- Option overrides for gitsigns preview window (options directly passed to
  -- `nvim_open_win`)
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

gitsigns.setup(config)
