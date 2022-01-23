local M = {}

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
  vim.notify("[my.lsp.handlers] failed to require 'cmp_nvim_lsp'", WARN)
  return
end

local keymaps = {
  normal_mode = {
    -- Goto definition
    ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
    -- Goto declaration
    ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
    -- Goto implementation
    ["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
    -- Goto references
    ["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",

    -- Show hover documentation in a float window
    ["K"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
    -- Show signature help in a float window
    ["gs"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",

    -- Goto next diagnostic
    ["[g"] = "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
    -- Goto previous diagnostic
    ["]g"] = "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
    -- Add buffer diagnostics to the location list
    ["<leader>q"] = "<cmd>lua vim.diagnostic.setloclist()<CR>",
  },
}

local mode_adapters = {
  normal_mode = "n",
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

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Sends request to LSP server to resolve document highlights for the current
-- text document position, if the capabilities are enabled
local function lsp_document_highlight(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local function lsp_commands()
  vim.cmd([[command! Format execute 'lua vim.lsp.buf.formatting()']])
end

local function lsp_key_mappings(bufnr)
  local opts = { noremap = true, silent = true }

  for mode, mode_keymaps in pairs(keymaps) do
    mode = mode_adapters[mode]
    for key, val in pairs(mode_keymaps) do
      vim.api.nvim_buf_set_keymap(bufnr, mode, key, val, opts)
    end
  end
end

M.setup = function()
  for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config(diagnostic_config)

  -- Set rounded corners on hover windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  )

  -- Set rounded corners on signature help windows
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
  )
end

M.on_attach = function(client, bufnr)
  lsp_key_mappings(bufnr)
  lsp_commands()
  lsp_document_highlight(client)
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
