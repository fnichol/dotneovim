return {
  -- A Lua powered greeter like vim-startify / dashboard-nvim
  --
  -- https://github.com/goolord/alpha-nvim
  {
    "goolord/alpha-nvim",
    dependencies = {
      -- Lua fork of vim-web-devicons for NeoVim
      --
      -- https://github.com/nvim-tree/nvim-web-devicons
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      local function button(sc, txt, keybind, keybind_opts)
        local b = dashboard.button(sc, txt, keybind, keybind_opts)
        b.opts.hl = "Function"
        b.opts.hl_shortcut = "Comment"
        return b
      end

      local function footer()
        local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
        local version = vim.version()
        return string.format("%s   v%s.%s.%s", datetime, version.major, version.minor, version.patch)
      end

      dashboard.section.header.opts.hl = "Keyword"
      dashboard.section.buttons.val = {
        button("f", "  Find file", ":Telescope find_files <CR>"),
        button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        button("p", "  Find project", ":Telescope projects <CR>"),
        button("r", "󰈢  Recently used files", ":Telescope oldfiles <CR>"),
        button("t", "  Find text", ":Telescope live_grep <CR>"),
        button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        button("q", "󰅚  Quit Neovim", ":qa<CR>"),
      }
      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Comment"

      dashboard.opts.opts.noautocmd = true

      -- Hide surrounding chrome until alpha is unloaded
      vim.api.nvim_exec(
        [[autocmd User AlphaReady ]]
          .. [[set showtabline=0 laststatus=0 noruler fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾ | ]]
          .. [[autocmd BufUnload <buffer> set showtabline=2 laststatus=2 ruler fillchars=]],
        false
      )

      require("alpha").setup(dashboard.config)
    end,
  },
}
