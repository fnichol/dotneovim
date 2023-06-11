vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.bxl",
  callback = function(args)
    vim.bo[args.buf].filetype = "bzl"
  end,
})
