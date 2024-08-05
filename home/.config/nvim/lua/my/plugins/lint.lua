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
    },
    config = function(_, opts)
      local lint = require("lint")

      local linters = require("my.mason.linters")
      local linters_manual = require("my.mason.linters_manual")

      local all_linters =
        vim.tbl_deep_extend("error", {}, linters.configuration, linters_manual.configuration)
      local all_by_filetypes =
        vim.tbl_deep_extend("error", {}, linters.by_filetype, linters_manual.by_filetype)

      opts.linters_by_ft = all_by_filetypes
      opts.linters = all_linters

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
