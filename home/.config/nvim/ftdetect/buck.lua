vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = { "BUCK", "BUCK.v2" },
  callback = function(args)
    vim.bo[args.buf].filetype = "bzl"
  end,
})
