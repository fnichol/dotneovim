local options = {
  -- Skips creating a backup file before overwriting [default: false]
  backup = false,
  -- Allows NeoVim access to the system clipboard [default: ""]
  clipboard = "unnamedplus",
  -- Allows more space in command line for displaying messages [default: 1]
  cmdheight = 2,
  -- Options for insert mode completion, set mostly for cmp
  -- [default { "menu", "preview" }]
  completeopt = { "menuone", "noselect" },
  -- Determines how text with "conceal" is displayed, set to that `` is
  -- visible in markdown files [default: 0]
  conceallevel = 0,
  -- Sets file-content encoding for reading and writing files [default: ""]
  fileencoding = "utf-8",
  -- Sets a list of fonts used in the GUI version of NeoVim [default: ""]
  guifont = "monospace:12",
  -- Highlights all matches on previous search patterns [default: true]
  hlsearch = true,
  -- Ignores case in search patterns [default: false]
  ignorecase = true,
  -- Enables mouse support for all modes [default: ""]
  mouse = "a",
  -- Sets maximum number of items to show in the popup menu [default: 0]
  pumheight = 10,
  -- Hides a message on last line when in Insert, Replace, or Visual mode
  -- [default: true]
  showmode = false,
  -- Always show the line with tab page labels [default: 1]
  showtabline = 2,
  -- Enables on case-sensitive search if pattern contains upper case letters
  -- [default: false]
  smartcase = true,
  -- Enables smart indenting when starting a new line [default: false]
  smartindent = true,
  -- When splitting a window horizontally, new window is below of current one
  -- [default: false]
  splitbelow = false,
  -- When splitting a window veritcally, new window is to the right of
  -- current one [default: false]
  splitright = true,
  -- Don't create a swapfile for buffers [default: true]
  swapfile = false,
  -- Enables 24-bit RGB color in the TUI [default: false]
  termguicolors = true,
  -- Sets timeout in milliseconds for a key code sequence to complete
  -- [default: 50]
  timeoutlen = 100,
  -- Enables persistent undo history [default: false]
  undofile = true,
  -- Helps to support faster completion [default: 4000]
  updatetime = 300,
  -- If a file is being edited by another program (or was written to file
  -- while editing with another program), it is not allowed to be edited
  -- [default: false]
  writebackup = false,

  -- Converts tab characters to spaces [default: false]
  expandtab = true,
  -- Sets the number of spaces to use for each step of indentation
  -- [default: 8]
  shiftwidth = 2,
  -- Set the number of spaces a tab character counts for [default: 0]
  tabstop = 2,
  -- Highlights the current line [default: false]
  cursorline = true,
  -- Prints the line number in front of each line [default: false]
  number = true,
  -- Sets the line number relative to the line with the cursor
  -- [default: false]
  relativenumber = false,
  -- Sets the minimal number of colums to use for the line number [default 4]
  numberwidth = 4,
  -- Always draw the sign column (otherwise it shifts the text around as it's
  -- needed) [default: "auto"]
  signcolumn = "yes",
  -- Don't display long lines as one line, but rather wrap them
  -- [default: true]
  wrap = true,
  -- Shows a minimal number of screen lnies to keep above or below the cursor
  -- [default: 0]
  scrolloff = 4,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Don't give ins-completion-menu messages [default: "filnxtToOF"]
vim.opt.shortmess:append("c")
