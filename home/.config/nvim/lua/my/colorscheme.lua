local colorscheme = "base16-twilight"

vim.cmd(string.format(
  [[
    try
      colorscheme %s
    catch /^Vim\%%((\a\+)\)\=:E185/
      echohl WarnMsg
      echom "[colorscheme] '%s' was not found!"
      echohl None
      colorscheme default
      set background=dark
    endtry
  ]],
  colorscheme,
  colorscheme
))
