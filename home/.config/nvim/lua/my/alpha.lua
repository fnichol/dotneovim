local ok, alpha = pcall(require, "alpha")
if not ok then
  vim.notify("[my.alpha] failed to require 'alpha'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/goolord/alpha-nvim

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[ _______             ____   ____.__         ]],
  [[ \      \   ____  ___\   \ /   /|__| _____  ]],
  [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
  [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
  [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
  [[        \/     \/                        \/ ]],
}
dashboard.section.header.opts.hl = "Keyword"

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "Function"
  b.opts.hl_shortcut = "Comment"
  return b
end

dashboard.section.buttons.val = {
  button("f", "  Find file", ":Telescope find_files <CR>"),
  button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  button("p", "  Find project", ":Telescope projects <CR>"),
  button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  button("t", "  Find text", ":Telescope live_grep <CR>"),
  button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
  local version = vim.version()
  return string.format("%s   v%s.%s.%s", datetime, version.major, version.minor, version.patch)
end

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

alpha.setup(dashboard.opts)
