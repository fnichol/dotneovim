M = {}

local sys = require("my.util.sys")

local configuration = {
  -- A tool for formatting Bazel BUILD, Buck2 BUCK, and .bzl files with a
  -- standard convention.
  --
  -- https://github.com/bazelbuild/buildtools/tree/master/buildifier
  buildifier = {
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
  -- Prettier is an opinionated code formatter.
  --
  -- https://github.com/prettier/prettier
  prettier = {},
  -- A shell parser, formatter, and interpreter with `bash` support.
  --
  -- https://github.com/mvdan/sh
  shfmt = {
    -- Mason package not available on OpenBSD
    install_condition = function()
      return not sys.on_openbsd()
    end,
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("shfmt") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
    args = function(self, ctx)
      local util = require("conform.util")

      local args = { "-filename", "$FILENAME" }
      local has_editorconfig_config = util.root_file({
        ".editorconfig",
      })(self, ctx) ~= nil

      -- If an EditorConfig config is set for the project, use this,
      -- otherwise fall back to the Google shell style conventions
      -- (https://google.github.io/styleguide/shell.xml)
      if not has_editorconfig_config then
        if vim.bo[ctx.buf].expandtab then
          vim.list_extend(args, { "-i", ctx.shiftwidth })
        else
          vim.list_extend(args, { "-i", "2" })
        end

        vim.list_extend(args, { "-bn", "-ci" })
      end

      return args
    end,
  },
  -- An opinionated code formatter for Lua.
  --
  -- https://github.com/JohnnyMorganz/StyLua
  stylua = {
    -- Mason package not available on OpenBSD
    install_condition = function()
      return not sys.on_openbsd()
    end,
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("stylua") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
    -- Only format Lua code that have a StyLua or Editorconfig
    -- configuration
    condition = function(self, ctx)
      local util = require("conform.util")

      local has_stylua_config = util.root_file({
        "stylua.toml",
        ".stylua.toml",
      })(self, ctx) ~= nil
      local has_editorconfig_config = util.root_file({
        ".editorconfig",
      })(self, ctx) ~= nil

      return has_stylua_config or has_editorconfig_config
    end,
  },
  -- Yet Another Python Formatter.
  --
  -- https://github.com/google/yapf
  yapf = {},
}

local by_filetype = {
  bzl = {
    "buildifier",
    -- Mason package and system package not available on OpenBSD
    install_and_use_condition = function()
      return not sys.on_openbsd()
    end,
  },
  css = { "prettier" },
  graphql = { "prettier" },
  handlebars = { "prettier" },
  html = { "prettier" },
  javascript = { "prettier" },
  javascriptreact = { "prettier" },
  json = { "prettier" },
  jsonc = { "prettier" },
  less = { "prettier" },
  lua = {
    "stylua",
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("stylua") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
  },
  markdown = { "prettier" },
  python = { "yapf" },
  scss = { "prettier" },
  sh = {
    "shfmt",
    -- Use executatble from system if present on OpenBSD
    use_condition = function()
      if sys.on_openbsd() then
        if sys.has_executable("shfmt") then
          return true
        else
          return false
        end
      else
        return true
      end
    end,
  },
  typescript = { "prettier" },
  typescriptreact = { "prettier" },
  vue = { "prettier" },
  yaml = { "prettier" },
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
