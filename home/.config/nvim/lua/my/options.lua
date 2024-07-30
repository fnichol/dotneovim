-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local options = {
  -- Allows NeoVim access to the system clipboard [default: ""]
  --  See `:help 'clipboard'`
  clipboard = "unnamedplus",
  -- Number of lines to use for the command-line [default: 1]
  cmdheight = 2,
  -- Options for insert mode completion, set mostly for cmp
  -- [default { "menu", "preview" }]
  completeopt = { "menuone", "noselect" },
  -- Highlights the current line [default: false]
  cursorline = true,
  -- Converts tab characters to spaces [default: false]
  expandtab = true,
  -- Sets file-content encoding for reading and writing files [default: ""]
  fileencoding = "utf-8",
  -- Ignores case in search patterns [default: false]
  ignorecase = true,
  -- List mode: display certain whitespace characters. [default: false]
  -- See: `:help 'list'`
  list = true,
  -- Strings to use in `'list'` mode. [default: "tab:> ,trail:-,nbsp:+"]
  -- See: `:help 'listchars'`
  listchars = { tab = "» ", trail = "·", nbsp = "␣" },
  -- Enables mouse support for all modes [default: ""]
  mouse = "a",
  -- Prints the line number in front of each line [default: false]
  number = true,
  -- Sets maximum number of items to show in the popup menu [default: 0]
  pumheight = 10,
  -- Shows a minimal number of screen lnies to keep above or below the cursor
  -- [default: 0]
  scrolloff = 4,
  -- Sets the number of spaces to use for each step of indentation
  -- [default: 8]
  shiftwidth = 2,
  -- Hides a message on last line when in Insert, Replace, or Visual mode
  -- [default: true]
  showmode = false,
  -- Always draw the sign column (otherwise it shifts the text around as it's
  -- needed) [default: "auto"]
  signcolumn = "yes",
  -- Enables on case-sensitive search if pattern contains upper case letters
  -- [default: false]
  smartcase = true,
  -- When splitting a window horizontally, new window is below of current one
  -- [default: false]
  splitbelow = false,
  -- When splitting a window veritcally, new window is to the right of
  -- current one [default: false]
  splitright = true,
  -- Don't create a swapfile for buffers [default: true]
  swapfile = false,
  -- Set the number of spaces a tab character counts for [default: 0]
  tabstop = 2,
  -- Enables 24-bit RGB color in the TUI [default: false]
  termguicolors = true,
  -- Sets timeout in milliseconds for a key code sequence to complete
  -- Displays which-key popup sooner
  -- [default: 50]
  timeoutlen = 300,
  -- Enables persistent undo history [default: false]
  undofile = true,
  -- Decreases update time, helps to support faster completion [default: 4000]
  updatetime = 250,
  -- Don't display long lines as one line, but rather wrap them
  -- [default: true]
  wrap = true,
  -- If a file is being edited by another program (or was written to file
  -- while editing with another program), it is not allowed to be edited
  -- [default: false]
  writebackup = false,
}

-- TODO: Review defaults from kickstart.nvim
--
-- -- Enable break indent
-- vim.opt.breakindent = true
--
-- -- Preview substitutions live, as you type!
-- vim.opt.inccommand = "split"

for k, v in pairs(options) do
  vim.opt[k] = v
end
