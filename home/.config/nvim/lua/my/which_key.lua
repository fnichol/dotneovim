local ok, which_key = pcall(require, "which-key")
if not ok then
  vim.notify("[my.which_key] failed to require 'which-key'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/folke/which-key.nvim

local mappings = {
  ["f"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
  ["r"] = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },

  --
  -- ## LSP
  --
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },

    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },

    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },

    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },

    q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },

    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },

    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
  },

  --
  -- ## Packer
  --
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    s = { "<cmd>PackerSync<CR>", "Sync" },
    S = { "<cmd>PackerStatus<CR>", "Status" },
    u = { "<cmd>PackerUpdate<CR>", "Update" },
  },

  --
  -- ## Search
  --
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<CR>", "Checkout Branch" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<CR>", "Find File" },
    h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
    m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Register" },
    t = { "<cmd>Telescope live_grep theme=ivy<CR>", "Text" },
    k = { "<cmd>Telescope keymaps<CR>", "Key Mapping" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({ enable_preview = true })<CR>",
      "Colorscheme With Preview",
    },
  },

  --
  -- ## Treesitter
  --
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<CR>", "Info" },
  },
}

local setup = {
  plugins = {
    -- Shows a list of your marks on ' and `
    marks = true,
    -- Shows your registers on " in Normal or <C-r> in Insert mode
    registers = true,
    spelling = {
      -- Enabling this will show WhichKey when pressing `z=` to select
      -- spelling sugestions
      enabled = true,
      -- Chooses how man suggestions to be shown in the list
      suggestions = 20,
    },
    presets = {
      -- Adds help for operators like d, y, ... and registers them for motion /
      -- text object completion
      operators = false,
      -- Adds help for motions
      motions = true,
      -- Adds help for text objects triggered after entering an operator
      text_objects = true,
      -- Default bindings on `<C-w>`
      windows = true,
      -- Adds miscellaneous binding to work with windows
      nav = true,
      -- Bindings for folds, spelling and others prefixed with `z`
      z = true,
      -- Bindings prefixed with `g`
      g = true,
    },
  },
  -- Add operators that will trigger motions and text object completion to
  -- enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {},
  icons = {
    -- Symbol used in the command line area that shows your active key combo
    breadcrumb = "»",
    -- Symbol used between a key and it's label
    separator = "➜",
    -- Symbol prepended to a group
    group = "+",
  },
  popup_mappings = {
    -- Binding to scroll down inside the popup
    scroll_down = "<c-d>",
    -- Binding to scroll up inside the popup
    scroll_up = "<c-u>",
  },
  window = {
    -- [values: none, single, double, shadow]
    border = "rounded",
    -- [values: bottom, top]
    position = "bottom",
    -- Extra window margin [top, right, bottom, left]
    margin = { 1, 0, 1, 0 },
    -- Extra window padding [top, right, bottom, left]
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    -- Min and max height of the columns
    height = { min = 4, max = 25 },
    -- Min and max width of the columns
    width = { min = 20, max = 50 },
    -- Spacing between columns
    spacing = 3,
    -- Align columns left, center or right
    align = "left",
  },
  -- Enable this to hide mappings for which you didn't specify a label
  ignore_missing = true,
  -- Hide mapping boilerplate
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  -- Show help message on the command line when the popup is visible
  show_help = true,
  -- Automatically setup triggers
  triggers = "auto",
  -- Or specify a list manually
  -- triggers = {"<leader>"}
  triggers_blacklist = {
    -- List of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  -- Normal mode
  mode = "n",
  --The prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  -- Global mappings. Specify a buffer number for local buffer local mappings
  buffer = nil,
  -- Use `silent` when creating key mappings
  silent = true,
  -- Use `noremap` when creating key mappings
  noremap = true,
  -- Use `nowait` when creating key mappings
  nowait = true,
}

which_key.setup(setup)
which_key.register(mappings, opts)
