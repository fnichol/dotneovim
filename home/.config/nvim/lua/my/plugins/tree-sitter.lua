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
