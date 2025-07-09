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
  -- Neovim Treesitter configurations and abstraction layer
  --
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    opts = {
      ensure_installed = parsers,
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Note: Some languages depend on vim's regex highlighting system (such
        -- as Ruby) for indent rules.
        --
        -- If you are experiencing weird indenting issues, add the language to
        -- the list of additional_vim_regex_highlighting and disabled languages
        -- for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, diable = { "ruby" } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
