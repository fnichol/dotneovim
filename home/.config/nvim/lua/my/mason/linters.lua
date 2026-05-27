M = {}

local sys = require("my.util.sys")

local configuration = {
  -- Catch insensitive, inconsiderate writing.
  --
  -- https://github.com/get-alex/alex
  alex = {},
  -- A new way of working with Protocol Buffers.
  --
  -- https://github.com/bufbuild/buf
  buf = {
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
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
  hadolint = {
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
  -- A pure JavaScript version of the service provided at jsonlint.com.
  --
  -- https://github.com/zaach/jsonlint
  jsonlint = {},
  -- A tool for linting and static analysis of Lua code.
  --
  -- https://github.com/lunarmodules/luacheck
  luacheck = {
    -- If `luarocks` executable is not present, then `luacheck` cannot be
    -- installed
    install_and_use_condition = function()
      return sys.has_executable("luarocks")
    end,
  },
  -- Markdown style and syntax checker.
  --
  -- https://github.com/DavidAnson/markdownlint
  markdownlint = {},
  -- A shell script static analysis tool.
  --
  -- https://www.shellcheck.net/
  shellcheck = {
    -- Mason package not available on OpenBSD
    install_condition = function()
      return not sys.on_openbsd()
    end,
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("shellcheck") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
  },
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
  dockerfile = {
    "hadolint",
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
  gitcommit = { "commitlint" },
  javascript = { "eslint" },
  javascriptreact = { "eslint" },
  json = { "jsonlint" },
  lua = {
    "luacheck",
    -- If `luarocks` executable is not present, then `luacheck` cannot be
    -- installed
    install_and_use_condition = function()
      return sys.has_executable("luarocks")
    end,
  },
  markdown = { "alex", "markdownlint" },
  proto = {
    "buf",
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
  python = { "flake8" },
  sh = {
    "shellcheck",
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("shellcheck") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
  },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  vim = { "vint" },
  vue = { "eslint" },
  yaml = { "yamllint" },
}

local table = require("my.util.table")

M.configuration = function()
  return table.filter_use_table(configuration)
end
M.install = function()
  return table.filter_install_list(configuration)
end
M.by_filetype = function()
  return table.filter_use_table(by_filetype)
end

return M
