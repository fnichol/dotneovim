-- Completion sources and ordering
local sources = {
  { name = "nvim_lsp" },
  { name = "nvim_lua" },
  { name = "luasnip" },
  { name = "buffer" },
  { name = "path" },
}

-- Completion menu source names
local menu_source_names = {
  buffer = "[Buffer]",
  luasnip = "[Snippet]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}

local ok, cmp = pcall(require, "cmp")
if not ok then
  vim.notify("[my.cmp] failed to require 'cmp'", vim.log.levels.WARN)
  return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
  vim.notify("[my.cmp] failed to require 'luasnip'", vim.log.levels.WARN)
  return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  vim.notify("[my.cmp] failed to require 'lspkind'", vim.log.levels.WARN)
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

-- Checks if the character preceding the cursor is a space character
-- @return boolean true if it is a space character and false otherwise
local function check_backspace()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Sets up a "Super-Tab" like mapping for the <Tab> key
-- @fallback function fallback function to default behavior
local function tab_mapping(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expandable() then
    luasnip.expand()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif check_backspace() then
    fallback()
  else
    fallback()
  end
end

-- Sets up a "Super-Tab" like mapping for the <S-Tab> key
-- @fallback function fallback function to default behavior
local function shift_tab_mapping(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    -- A snippet engine is required
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Use C+up/down motion keys to navigate the previous and next items
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    -- Use C+left/right motion keys to navigate the previous and next items
    ["<C-h>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-l>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- Trigger the completion dialog/mode without having to type any leading text
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- Remove the default <C-y> mapping
    ["<C-y>"] = cmp.config.disable,
    -- Exit the completion dialog/mode
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    -- Accept currently selected item. If none is selected, `select` the first
    -- item
    -- Set `select` to `false` to only confirm the explicitly selected items
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- Setup a "Super-Tab" like mapping
    ["<Tab>"] = cmp.mapping(tab_mapping, { "i", "s" }),
    -- Setup a reverse "Super-Tab" like mapping
    ["<S-Tab>"] = cmp.mapping(shift_tab_mapping, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      -- Don't show text alongside icons
      with_text = false,
      -- Prevent the popup from showing more than the given chanracters
      maxwidth = 80,
      -- Display sources of completions
      menu = menu_source_names,
    }),
  },
  sources = sources,
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})
