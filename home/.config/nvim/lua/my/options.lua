-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local options = {
  -- Allows NeoVim access to the system clipboard [default: ""]
  --  See `:help 'clipboard'`
  clipboard = "unnamedplus",
  -- Highlights the current line [default: false]
  cursorline = true,
  -- Ignores case in search patterns [default: false]
  ignorecase = true,
  -- Enables mouse support for all modes [default: ""]
  mouse = "a",
  -- Prints the line number in front of each line [default: false]
  number = true,
  -- Shows a minimal number of screen lnies to keep above or below the cursor
  -- [default: 0]
  scrolloff = 4,
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
  -- Sets timeout in milliseconds for a key code sequence to complete
  -- Displays which-key popup sooner
  -- [default: 50]
  timeoutlen = 300,
  -- Enables persistent undo history [default: false]
  undofile = true,
  -- Decreases update time, helps to support faster completion [default: 4000]
  updatetime = 250,
}

-- TODO: Review defaults from kickstart.nvim
--
-- -- Enable break indent
-- vim.opt.breakindent = true
--
-- -- Sets how neovim will display certain whitespace characters in the editor.
-- --  See `:help 'list'`
-- --  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
--
-- -- Preview substitutions live, as you type!
-- vim.opt.inccommand = "split"

for k, v in pairs(options) do
  vim.opt[k] = v
end
