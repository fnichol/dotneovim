vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.bu" },
  callback = function(args)
    vim.bo[args.buf].filetype = "yaml"
  end,
})
