local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

-- Leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", generic_opts_any)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymaps = {
  insert_mode = {
    -- Navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },

  normal_mode = {
    -- Window navigation movement (C-<motion-keys>)
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":bnext<CR>",
    ["<S-h>"] = ":bprevious<CR>",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",
  },

  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },

  visual_mode = {
    -- Preserve selection after indentation
    [">"] = ">gv",
    ["<"] = "<gv",

    -- Map tab/shift-tab to indent
    ["<Tab>"] = ">gv",
    ["<S-Tab>"] = "<gv",
  },

  visual_block_mode = {},

  command_mode = {
    -- Navigate tab completion with <C-j> and <C-k>
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

-- On macOS, map normal mode window resizing keys to (<A-<arrows>)
if vim.fn.has("mac") == 1 then
  keymaps.normal_mode["<A-Up>"] = keymaps.normal_mode["<C-Up>"]
  keymaps.normal_mode["<A-Down>"] = keymaps.normal_mode["<C-Down>"]
  keymaps.normal_mode["<A-Left>"] = keymaps.normal_mode["<C-Left>"]
  keymaps.normal_mode["<A-Right>"] = keymaps.normal_mode["<C-Right>"]
end

-- Set a key mapping
-- @param mode The keymap mode
-- @param key The key of the keymap
-- @param val Can be a mapping or tuple of mapping and user defined opt
local function set_keymap(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if val then
    vim.api.nvim_set_keymap(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode
-- @param keymaps The table of key mappings
local function load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    set_keymap(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of all keymaps for each mode
local function load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    load_mode(mode, mapping)
  end
end

load(keymaps)
