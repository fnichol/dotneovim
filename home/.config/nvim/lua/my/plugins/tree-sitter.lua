-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
local parsers = {
  "awk",
  "bash",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "dot",
  "editorconfig",
  "embedded_template",
  "git_config",
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
  "jq",
  "jsdoc",
  "json",
  "json5",
  "kdl",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "ninja",
  "nix",
  "perl",
  "php",
  "powershell",
  "proto",
  "python",
  "regex",
  "rst",
  "ron",
  "ruby",
  "rust",
  "scss",
  "sql",
  "ssh_config",
  "starlark",
  "tmux",
  "toml",
  "typescript",
  "vim",
  "vue",
  "xml",
  "yaml",
  "zig",
}

return {
  -- A lightweight Tree-sitter parser manager for Neovim
  --
  -- https://github.com/romus204/tree-sitter-manager.nvim
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- `tree-sitter` CLI must be installed system wide
    init = function()
      -- Thanks to: https://mise.jdx.dev/mise-cookbook/neovim.html
      --
      require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ":t")

        return string.match(filename, ".*mise.*%.toml$") ~= nil
      end, { force = true, all = false })
    end,
    config = function()
      require("tree-sitter-manager").setup({
        ensure_installed = parsers,
        -- Autoinstall languages that are not installed
        auto_install = true,
        -- Note: Some languages depend on vim's regex highlighting system (such
        -- as Ruby) for indent rules.
        --
        -- If you are experiencing weird indenting issues, add the language to
        -- the list of nohighlight languages for indent.
        nohighlight = { "ruby" },
      })
    end,
  },
}
