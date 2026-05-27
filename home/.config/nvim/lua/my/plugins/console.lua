return {
  -- A handy scratch pad / REPL / debug console for Lua development and Neovim
  -- exploration
  --
  -- https://github.com/YaroSpace/lua-console.nvim
  {
    "yarospace/lua-console.nvim",
    lazy = true,
    keys = {
      { "`", desc = "Lua-console - toggle" },
      { "<leader>`", desc = "Lua-console - attach to buffer" },
    },
    opts = {},
  },
}
