M = {}

local configuration = {
  -- Catch insensitive, inconsiderate writing.
  --
  -- https://github.com/get-alex/alex
  alex = {},
  -- A new way of working with Protocol Buffers.
  --
  -- https://github.com/bufbuild/buf
  buf = {},
  -- buf_lint = {},
  -- commitlint checks if your commit messages meet the conventional
  -- commit format.
  --
  -- https://commitlint.js.org
  commitlint = {},
  -- A linter for the JavaScript ecosystem.
  --
  -- https://github.com/eslint/eslint
  eslint = {},
  -- A python tool that glues together pycodestyle, pyflakes, mccabe, and
  -- third-party plugins to check the style and quality of Python code.
  --
  -- https://github.com/PyCQA/flake8
  flake8 = {},
  -- A smarter Dockerfile linter that helps you build best practice
  -- Docker images.
  --
  -- https://github.com/hadolint/hadolint
  hadolint = {},
  -- A pure JavaScript version of the service provided at jsonlint.com.
  --
  -- https://github.com/zaach/jsonlint
  jsonlint = {},
  -- A tool for linting and static analysis of Lua code.
  --
  -- https://github.com/lunarmodules/luacheck
  luacheck = {},
  -- Markdown style and syntax checker.
  --
  -- https://github.com/DavidAnson/markdownlint
  markdownlint = {},
  -- A shell script static analysis tool.
  --
  -- https://www.shellcheck.net/
  shellcheck = {},
  -- Linter for Vimscript.
  --
  -- https://github.com/Vimjas/vint
  vint = {},
  -- A linter for YAML files.
  --
  -- https://github.com/adrienverge/yamllint
  yamllint = {},
}

local by_filetype = {
  dockerfile = { "hadolint" },
  gitcommit = { "commitlint" },
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  json = { "jsonlint" },
  lua = { "luacheck" },
  markdown = { "alex", "markdownlint" },
  proto = { "buf_lint" },
  python = { "flake8" },
  sh = { "shellcheck" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  vim = { "vint" },
  vue = { "eslint" },
  yaml = { "yamllint" },
}

-- If `luarocks` program is not available then `luacheck` cannot be installed
if vim.fn.executable("luarocks") ~= 1 then
  configuration["luacheck"] = nil

  by_filetype["lua"] = nil
end

M.configuration = configuration
M.by_filetype = by_filetype

return M
