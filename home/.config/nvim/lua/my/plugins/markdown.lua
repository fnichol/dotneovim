return {
  -- An asynchronous markdown preview plugin for Vim and Neovim.
  --
  -- https://github.com/euclio/vim-markdown-composer
  {
    "euclio/vim-markdown-composer",
    enabled = function()
      return vim.fn.executable("cargo") == 1
    end,
    build = "cargo build --release --locked",
    init = function()
      -- Prevent vim-markdown-composer from auto-starting
      vim.g.markdown_composer_autostart = "0"
    end,
  },
}
