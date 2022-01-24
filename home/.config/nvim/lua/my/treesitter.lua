local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("[my.treesitter] failed to require 'nvim-treesitter.configs'", vim.log.levels.WARN)
  return
end

-- Usage: https://github.com/nvim-treesitter/nvim-treesitter

configs.setup({
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = { "" },
  autopairs = {
    enable = true,
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- List of language that will be disabled
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
