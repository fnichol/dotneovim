vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "BUCK",
  callback = function(args)
    vim.bo[args.buf].filetype = "starlark"
  end,
})
