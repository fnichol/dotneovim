vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Tiltfile" },
  callback = function(args)
    vim.bo[args.buf].filetype = "bzl"
  end,
})
