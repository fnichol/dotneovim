return {
  -- A completion plugin for NeoVim coded in Lua.
  --
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine for NeoVim written in Lua.
      --
      -- https://github.com/L3MON4D3/LuaSnip
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          -- Set of preconfigured snippets for different languages.
          --
          -- https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      -- LuaSnip completion source for nvim-cmp
      --
      -- https://github.com/saadparwaiz1/cmp_luasnip
      { "saadparwaiz1/cmp_luasnip" },
      -- nvim-cmp source for neovim builtin LSP client
      --
      -- https://github.com/hrsh7th/cmp-nvim-lsp
      { "hrsh7th/cmp-nvim-lsp" },
      -- nvim-cmp source for buffer words
      --
      -- https://github.com/hrsh7th/cmp-buffer
      { "hrsh7th/cmp-buffer" },
      --  nvim-cmp source for filesystem paths
      --
      -- https://github.com/hrsh7th/cmp-path
      { "hrsh7th/cmp-path" },
      -- nvim-cmp source for Vim's cmdline
      --
      -- https://github.com/hrsh7th/cmp-cmdline
      { "hrsh7th/cmp-cmdline" },
      -- nvim-cmp source for NeoVim Lua
      --
      -- https://github.com/hrsh7th/cmp-nvim-lua
      { "hrsh7th/cmp-nvim-lua" },
      -- LuaSnip completion source for nvim-cmp
      --
      -- https://github.com/saadparwaiz1/cmp_luasnip
      { "saadparwaiz1/cmp_luasnip" },
      -- vscode-like pictograms for NeoVim LSP completion items
      --
      -- https://github.com/onsails/lspkind.nvim
      { "onsails/lspkind-nvim" },
      -- A Neovim plugin that helps managing crates.io dependencies
      --
      -- https://github.com/Saecki/crates.nvim
{
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          completion = {
            cmp = { enabled = true },
          },
        },
      },
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          -- Select the [p]revious and [n]ext item
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),

          -- Scroll the documentation window [b]ack and [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion
          -- This will auto-import if your LSP supports it
          -- This will expand snippets if the LSP sent a snippet
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- Exit the completion
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),

          -- Manually trigger a completion from nvim-cmp.
          -- Generally you don't need this because nvim-cmp will display
          -- completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          -- So if you have a snippet that's like:
          --
          --   function $name($args)
          --     $body
          --   end
          --
          -- <C-l> will move you to the right of each of the expansion locations.
          -- <C-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable(-1) then
              luasnip.expand_or_jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as
            -- lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "crates" },
          { name = "nvim_lua" },
          { name = "vim-dadbod-completion" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = function()
              return math.min(80, math.floor(0.45 * vim.o.columns))
            end,
          }),
        },
      })
    end,
  },
}
