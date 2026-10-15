-- [[ Install `lazy.nvim` plugin manager ]]
--
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/lazy.nvim")
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    if #vim.api.nvim_list_uis() == 0 then
      -- Headless: there is no one to press a key, so fail instead of blocking
      io.stderr:write("Failed to clone lazy.nvim:\n" .. out .. "\n")
      os.exit(1)
    end
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  -- Ensure the Git checkout for Lazy.nvim respects the lockfile
  local lockfile_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lazy-lock.json")
  local f = io.open(lockfile_path, "r")
  if f then
    local ok, lock = pcall(vim.json.decode, f:read("*a"))
    f:close()
    if ok and lock["lazy.nvim"] then
      vim.fn.system({ "git", "-C", lazypath, "checkout", lock["lazy.nvim"].commit })
    end
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local sys = require("my.util.sys")

local concurrency = 24
if sys.on_openbsd() then
  concurrency = 6
end

require("lazy").setup({
  spec = {
    { import = "my.plugins" },
  },
  checker = {
    -- Automatically check for plugin updates
    enabled = true,
    -- Limit the number of concurrent checks on systems with low open file handles ulimit
    concurrency = concurrency,
    -- Check for updates once a day
    frequency = 60 * 60 * 24,
  },
  git = {
    throttle = {
      enabled = true,
      -- Set max `$rate` ops per `$duration` ms
      rate = 6,
      -- Duration in ms
      duration = 1000,
    },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
