return {
  -- Lightweight yet powerful formatter plugin for Neovim
  --
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        bzl = { "buildifier" },
        css = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        hcl = { "packer_fmt" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        less = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        nix = { "alejandra" },
        python = { "yapf" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        sh = { "shfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        yaml = { "prettier" },
      },
    },
    config = function(_, opts)
      local util = require("conform.util")

      opts.formatters = {
        -- The Uncompromising Nix Code Formatter.
        --
        -- https://kamadorueda.com/alejandra/
        alejandra = {
          -- Only activate formatter if program is found on system (this is not
          -- a Mason-installed program)
          condition = function()
            return vim.fn.executable("alejandra") == 1
          end,
        },
        -- A tool for formatting Bazel BUILD, Buck2 BUCK, and .bzl files with a
        -- standard convention.
        --
        -- https://github.com/bazelbuild/buildtools/tree/master/buildifier
        buildifier = {},
        -- Formats HCL2 configuration files to a canonical format and style.
        --
        -- https://developer.hashicorp.com/packer/docs/commands/fmt
        packer = {
          -- Only activate formatter if program is found on system (this is not
          -- a Mason-installed program)
          condition = function()
            return vim.fn.executable("packer") == 1
          end,
        },
        -- Prettier is an opinionated code formatter.
        --
        -- https://github.com/prettier/prettier
        prettier = {},
        -- A tool for formatting rust code according to style guidelines.
        --
        -- https://github.com/rust-lang/rustfmt
        rustfmt = {},
        -- A shell parser, formatter, and interpreter with `bash` support.
        --
        -- https://github.com/mvdan/sh
        shfmt = {
          args = function(self, ctx)
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

      require("conform").setup(opts)
    end,
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
  },
}
