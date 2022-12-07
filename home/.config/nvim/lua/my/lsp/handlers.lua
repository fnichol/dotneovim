local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

local M = {}

local ok, cmp_nvim_lsp = require_or_warn("cmp_nvim_lsp")
if not ok then
  return
end

local lsp_signature_ok, lsp_signature = require_or_warn("lsp_signature")
if not lsp_signature_ok then
  return
end

local wk_ok, which_key = require_or_warn("which-key")
if not wk_ok then
  return
end

local ill_ok, illuminate = require_or_warn("illuminate")
if not ill_ok then
  return
end

local mappings = {
  [""] = {
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Hover Documentation (LSP)" },
  },
  ["<leader>"] = {
    F = { "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", "Format (LSP)" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },

      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },

      j = {
        "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
        "Goto Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
        "Goto Prev Diagnostic",
      },

      q = {
        "<cmd>lua vim.diagnostic.setloclist()<CR>",
        "Add Buffer Diagnostics to Location List",
      },

      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },

      s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
    },
  },
  ["g"] = {
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition (LSP)" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration (LSP)" },
    I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation (LSP)" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto References (LSP)" },

    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help (LSP)" },
  },
  ["["] = {
    d = {
      "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
      "Goto Previous Diagnostic",
    },
  },
  ["]"] = {
    d = {
      "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
      "Goto Next Diagnostic",
    },
  },
}

local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

local diagnostic_config = {
  -- Options for floating diagnostic windows
  float = {
    -- Border window style
    border = "rounded",
    -- Don't make the floating window focusable
    focusable = false,
    -- String to use as the header for the floating window
    header = "",
    -- Prefix each diagnostic in the floating window
    prefix = "",
    -- Include the diagnostic source in the message
    source = "always",
    -- NeoVim will display the window with many UI options disabled
    style = "minimal",
  },
  -- Use signs for diagnostics
  signs = { active = diagnostic_signs },
  -- Use underline for diagnostics [default: true]
  underline = true,
  -- Update diagnostics in Insert mode [default: false]
  update_in_insert = true,
  -- Sort diagnostics by severity [default: false]
  severity_sort = true,
  -- Use virtual text for diagnostics [default: true]
  virtual_text = true,
}

local function lsp_commands()
  vim.cmd([[command! Format execute 'lua vim.lsp.buf.format{ async = true }']])
end

local function lsp_key_mappings(bufnr)
  for prefix, buffer_mappings in pairs(mappings) do
    which_key.register(buffer_mappings, { prefix = prefix, buffer = bufnr })
  end
end

M.setup = function()
  for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(diagnostic_config)

  -- Set rounded corners on hover windows
  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  -- Set rounded corners on signature help windows
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

M.on_attach = function(client, bufnr)
  -- disable jsonls formatting
  if client.name == "jsonls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- disable sumneko_lua formatting
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- disable tsserver formatting
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- disable volar formatting
  if client.name == "volar" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_key_mappings(bufnr)
  lsp_commands()
  lsp_signature.on_attach()
  illuminate.on_attach(client)
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
