vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ign" },
  callback = function(args)
    vim.bo[args.buf].filetype = "json"
  end,
})
