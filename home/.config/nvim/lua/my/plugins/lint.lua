return {
  -- An asynchronous linter plugin for Neovim complementary to the built-in
  -- Language Server Protocol support.
  --
  -- https://github.com/mfussenegger/nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Events to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
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
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      ---@type table<string,table>
      opts.linters = {
        -- Catch insensitive, inconsiderate writing.
        --
        -- https://github.com/get-alex/alex
        alex = {},
        -- A new way of working with Protocol Buffers.
        --
        -- https://github.com/bufbuild/buf
        buf_lint = {},
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

      local M = {}

      -- See: https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/linting.lua#L47-L56
      M.debounce = function(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      -- See: https://github.com/LazyVim/LazyVim/blob/12818a6cb499456f4903c5d8e68af43753ebc869/lua/lazyvim/plugins/linting.lua#L58-L91
      M.lint = function()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype
        --   that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original
        names = vim.list_extend({}, names)

        -- Add fallback linters
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Run linters
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      local lint_augroup = vim.api.nvim_create_augroup("my-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = M.debounce(100, M.lint),
      })

      vim.api.nvim_create_user_command("LinterInfo", function()
        local running_linters = table.concat(require("lint").get_running(), "\n")
        vim.notify(running_linters, vim.log.levels.INFO, { title = "nvim-lint" })
      end, {})
    end,
    cmd = { "LinterInfo" },
  },
}
