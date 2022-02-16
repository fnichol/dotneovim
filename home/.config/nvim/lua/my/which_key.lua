local ok, which_key = pcall(require, "which-key")
if not ok then
  vim.notify("[my.which_key] failed to require 'which-key'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/folke/which-key.nvim

local mappings = {
  ["a"] = { "<cmd>Alpha<CR>", "Alpha" },
  ["b"] = { "<cmd>lua require('my.telescope').list_buffers()<CR>", "Buffers" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  ["f"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["r"] = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },

  --
  -- ## Debugging
  --
  d = {
    name = "Debugging",
    t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle DAP UI" },

    b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    B = {
      "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Breakpoint Condition",
    },
    L = {
      "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      "Set Log Point",
    },
    T = { "<cmd>lua require('dap').list_breakpoints()<CR>", "Lists All Breakpoints" },
    x = { "<cmd>lua require('dap').clear_breakpoints()<CR>", "Clears All Breakpoints" },

    c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
    C = { "<cmd>lua require('dap').run_to_cursor()<CR>", "Run To Cursor" },

    o = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
    i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
    O = { "<cmd>lua require('dap').step_into()<CR>", "Step Out" },

    j = { "<cmd>lua require('dap').down()<CR>", "Go Down Stacktrace" },
    k = { "<cmd>lua require('dap').up()<CR>", "Go Up Stacktrace" },

    l = { "<cmd>lua require('dap').run_last()<CR>", "Run Last" },
    r = { "<cmd>lua require('dap').repl.toggle()<CR>", "Toggle REPL" },
  },

  --
  -- ## Git
  --
  g = {
    name = "Git",
    f = { "<cmd>G<CR>", "Fugitive" },
    g = { "<cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
    j = { "<cmd>lua require('gitsigns').next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require('gitsigns').prev_hunk()<CR>", "Prev Hunk" },
    l = { "<cmd>lua require('gitsigns').blame_line()<CR>", "Blame" },
    p = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk" },
    r = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage Hunk" },
    u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<CR>", "Open Changed File" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout Branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout Commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<CR>", "Diff" },
  },

  --
  -- ## LSP
  --
  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    -- For activated buffer-local mappings, see `lua/my/lsp/handlers.lua`
  },

  --
  -- ## Terminal
  --
  m = {
    name = "Terminal",
    b = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
    f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Veritcal" },
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

  -- ## Treesitter
  --
  S = {
    name = "Treesitter",
    i = { ":TSConfigInfo<CR>", "Info" },
  },

  --
  -- ## Trouble
  --
  t = {
    name = "Trouble",
    d = { "<cmd>Trouble document_diagnostics<CR>", "Toggle Document Diagnostics" },
    D = { "<cmd>Trouble lsp_definitions<CR>", "LSP Definitions" },
    l = { "<cmd>Trouble loclist<CR>", "Location List" },
    q = { "<cmd>Trouble quickfix<CR>", "QuickFix" },
    r = { "<cmd>TroubleRefresh<CR>", "Refresh Diagnostics" },
    R = { "<cmd>Trouble lsp_references<CR>", "LSP References" },
    w = { "<cmd>Trouble workspace_diagnostics<CR>", "Toggle Workspace Diagnostics" },
  },

  --
  -- ## Toggle
  --
  T = {
    name = "Toggle",
    d = { "<cmd>lua require('dapui').toggle()<CR>", "DAP UI" },
    t = { "<cmd>TransparentToggle<CR>", "Transparent" },
    T = { "<cmd>TroubleToggle<CR>", "Trouble" },
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
