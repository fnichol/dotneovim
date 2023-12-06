local parsers = {
  "awk",
  "bash",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "dot",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "graphql",
  "hcl",
  "hjson",
  "html",
  "http",
  "ini",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "nix",
  "perl",
  "php",
  "proto",
  "python",
  "regex",
  "rst",
  "ruby",
  "rust",
  "scss",
  "sql",
  "starlark",
  "toml",
  "typescript",
  "vim",
  "vue",
  "yaml",
  "zig",
}

local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

local configs_ok, configs = require_or_warn("nvim-treesitter.configs")
if not configs_ok then
  return
end

local tscc_ok, tscc = require_or_warn("ts_context_commentstring")
if not tscc_ok then
  return
end

-- Usage: https://github.com/nvim-treesitter/nvim-treesitter
-- Usage: https://github.com/JoosepAlviste/nvim-ts-context-commentstring

tscc.setup({
  enable_autocmd = false,
})

configs.setup({
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = parsers,
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = {},
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
})
