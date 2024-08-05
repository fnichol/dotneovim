M = {}

local configuration = {
  -- A tool for formatting Bazel BUILD, Buck2 BUCK, and .bzl files with a
  -- standard convention.
  --
  -- https://github.com/bazelbuild/buildtools/tree/master/buildifier
  buildifier = {},
  -- Prettier is an opinionated code formatter.
  --
  -- https://github.com/prettier/prettier
  prettier = {},
  -- A shell parser, formatter, and interpreter with `bash` support.
  --
  -- https://github.com/mvdan/sh
  shfmt = {
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
  bzl = { "buildifier" },
  css = { "prettier" },
  graphql = { "prettier" },
  handlebars = { "prettier" },
  html = { "prettier" },
  javascript = { "prettier" },
  javascriptreact = { "prettier" },
  json = { "prettier" },
  jsonc = { "prettier" },
  less = { "prettier" },
  lua = { "stylua" },
  markdown = { "prettier" },
  python = { "yapf" },
  scss = { "prettier" },
  sh = { "shfmt" },
  typescript = { "prettier" },
  typescriptreact = { "prettier" },
  vue = { "prettier" },
  yaml = { "prettier" },
}

-- If running on OpenBSD, remove language servers and tools that aren't yet
-- supported
if vim.uv.os_uname().sysname == "OpenBSD" then
  configuration["buildifier"] = nil
  configuration["shfmt"] = nil
  configuration["stylua"] = nil

  by_filetype["bzl"] = nil
  by_filetype["sh"] = nil
  by_filetype["lua"] = nil
end

M.configuration = configuration
M.by_filetype = by_filetype

return M
