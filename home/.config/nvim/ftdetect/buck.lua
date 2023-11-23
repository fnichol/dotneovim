vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "BUCK",
  callback = function(args)
    vim.bo[args.buf].filetype = "bzl"
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "BUCK.v2",
  callback = function(args)
    vim.bo[args.buf].filetype = "bzl"
  end,
})
