vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "compose.*.yaml",
    "compose.*.yml",
    "compose.yaml",
    "compose.yml",
    "docker-compose.*.yaml",
    "docker-compose.*.yml",
    "docker-compose.yaml",
    "docker-compose.yml",
  },
  callback = function(args)
    vim.bo[args.buf].filetype = "yaml.docker-compose"
  end,
})
