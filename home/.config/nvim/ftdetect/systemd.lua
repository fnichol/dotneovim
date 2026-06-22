vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.service", "*.container" },
  callback = function(args)
    vim.bo[args.buf].filetype = "systemd"
  end,
})
