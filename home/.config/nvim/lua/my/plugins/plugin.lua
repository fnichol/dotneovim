---Default time to wait for headless installs to finish, in seconds
local DEFAULT_INSTALL_TIMEOUT_SECS = 15 * 60

---Prints an error to stderr and exits Neovim with a non-zero status
---@param msg string
local fail = function(msg)
  io.stderr:write(msg .. "\n")
  vim.cmd("cquit 1")
end

---Reads the Lazy.nvim lockfile
---@return table<string, { commit?: string }>
local read_lazy_lockfile = function()
  local f = io.open(require("lazy.core.config").options.lockfile, "r")
  if not f then
    return {}
  end

  local ok, lock = pcall(vim.json.decode, f:read("*a"))
  f:close()

  return ok and lock or {}
end

---Returns names of Lazy.nvim plugins with task errors or that are not at their
---locked commit
---
---Lazy.nvim logs but does not always flag failed checkouts as task errors, and
---rewrites its lockfile after a restore, so the lockfile is read beforehand
---and compared to each plugin's HEAD.
---@param locked table<string, { commit?: string }> Lockfile entries read
---before the restore
---@return string[]
local lazy_failures = function(locked)
  local failed = {}

  for name, plugin in pairs(require("lazy.core.config").plugins) do
    local bad = require("lazy.core.plugin").has_errors(plugin)
    if not bad and locked[name] and locked[name].commit then
      local head = vim
        .system({ "git", "-C", plugin.dir, "rev-parse", "HEAD" }, { text = true })
        :wait()
      bad = head.code ~= 0 or vim.trim(head.stdout) ~= locked[name].commit
    end
    if bad then
      table.insert(failed, name)
    end
  end

  table.sort(failed)

  return failed
end

---Restores plugins and packages from lock files
---
---With a bang (`:PluginInstall!`) no UI is opened. When run headless this
---blocks until all Lazy.nvim plugins and Mason packages are installed, exiting
---non-zero on any failure or if `$NVIM_PLUGIN_INSTALL_TIMEOUT` (seconds,
---default 900) elapses:
---
---    nvim --headless "+PluginInstall!" +qall
---
---@param cmd vim.api.keyset.create_user_command.command_args
local install_plugins = function(cmd)
  local interactive = cmd.bang ~= true

  -- Lazy.nvim plugins
  --
  local lazy_locked = read_lazy_lockfile()
  require("lazy").restore({ wait = true })
  if interactive then
    require("lazy.view").view:close()
  end

  local lazy_failed = interactive and {} or lazy_failures(lazy_locked)

  --- Mason packages
  ---
  if interactive then
    require("mason.ui").open()
  end

  local result
  require("mason-lock").restore(require("my.util.mason").ensure_installed_list(), {
    interactive = interactive,
    on_done = function(r)
      result = r
    end,
  })

  if interactive then
    return
  end

  local timeout_secs = tonumber(vim.env.NVIM_PLUGIN_INSTALL_TIMEOUT) or DEFAULT_INSTALL_TIMEOUT_SECS
  if not vim.wait(timeout_secs * 1000, function()
    return result ~= nil
  end, 100) then
    return fail(("Timed out after %ds waiting for Mason packages"):format(timeout_secs))
  end

  if #lazy_failed > 0 then
    return fail("Failed Lazy.nvim plugins: " .. table.concat(lazy_failed, ", "))
  end
  if #result.failed > 0 then
    return fail("Failed Mason packages: " .. table.concat(result.failed, ", "))
  end
end

local update_plugins = function()
  -- Lazy.nvim plugins
  --

  require("lazy").update({ wait = true })
  require("lazy.view").view:close()

  --- Mason packages
  ---

  -- Wait until `MasonToolsUpdateCompleted` event has fired, then write
  -- lockfile and close UI
  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    group = vim.api.nvim_create_augroup("PluginUpdateMason", { clear = true }),
    once = true,
    callback = function()
      require("mason-lock").write_lockfile()
      require("mason-lock").close_ui()
    end,
  })

  require("mason.ui").open()
  require("mason-tool-installer").check_install(true)
end

return {
  name = "plugin-commands",
  dir = vim.fn.stdpath("config"),
  config = function()
    -- Can be used with `nvim --headless "+PluginInstall!" +qall`
    vim.api.nvim_create_user_command(
      "PluginInstall",
      install_plugins,
      { desc = "Restore plugins and packages from lock files", bang = true }
    )

    vim.api.nvim_create_user_command(
      "PluginUpdate",
      update_plugins,
      { desc = "Update plugins and packages, then update lock files" }
    )
  end,
}
