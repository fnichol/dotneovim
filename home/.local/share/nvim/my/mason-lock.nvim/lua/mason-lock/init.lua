local M = {}

local table_ext = require("my.util.table")
local registry = require("mason-registry")
local mlsp = require("mason-lspconfig")
local mdap = require("mason-nvim-dap.mappings.source")
local Terminal = require("lazy.terminal")

---@param msg string
---@param interactive boolean
local info = vim.schedule_wrap(function(msg, interactive)
  if interactive then
    vim.notify(msg, vim.log.levels.INFO, { title = "mason-lock" })
  else
    io.write(Terminal.prefix(msg, Terminal.magenta("[mason-lock]") .. Terminal.bright_black(" | ")))
    io.write("\n")
  end
end)

---@param msg string
---@param interactive boolean
local error = vim.schedule_wrap(function(msg, interactive)
  if interactive then
    vim.notify(msg, vim.log.levels.ERROR, { title = "mason-lock" })
  else
    io.write(Terminal.prefix(msg, Terminal.magenta("[mason-lock]") .. Terminal.bright_black(" | ")))
    io.write("\n")
  end
end)

local close_ui = function()
  vim.schedule(function()
    -- Find and close Mason window
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
      if ft == "mason" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end)
end
M.close_ui = close_ui

---Writes entries to lockfile at the given path.
---@param lockfile_path string Path to the lockfile
---@param entries_tbl table<string, string> Table of `pkg_name` -> `pkg_version` entries
local write_lockfile_entries = function(lockfile_path, entries_tbl)
  local entries = {}
  -- Create a list from the table
  for pkg_name, pkg_version in pairs(entries_tbl) do
    table.insert(entries, { name = pkg_name, version = pkg_version })
  end
  -- Sort list lexically in place by name
  table.sort(entries, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  if vim.fn.filereadable(lockfile_path) ~= 1 then
    -- Create parent directory
    vim.fn.mkdir(vim.fs.dirname(lockfile_path), "p")
  end

  local f = assert(io.open(lockfile_path, "wb"))
  f:write("{\n")

  for index, entry in ipairs(entries) do
    f:write(([[  %q: %q]]):format(entry.name, entry.version))
    if index ~= #entries then
      f:write(",\n")
    end
  end

  f:write("\n}\n")
  f:close()
end

---Path to the lockfile
M.lockfile_path = vim.fs.joinpath(vim.fn.stdpath("config"), "mason-lock.json")

---Returns whether or not the given lockfile exists.
---@param lockfile_path? string Optional path to the lockfile
---@return boolean
local lockfile_exists = function(lockfile_path)
  return vim.fn.filereadable(lockfile_path or M.lockfile_path) == 1
end
M.lockfile_exists = lockfile_exists

---Creates an empty lockfile if one does not exist.
---@param lockfile_path? string Optional path to the lockfile
local create_if_missing = function(lockfile_path)
  if lockfile_path == nil then
    lockfile_path = M.lockfile_path
  end

  if not lockfile_exists(lockfile_path) then
    write_lockfile_entries(lockfile_path, {})
  end
end
M.create_if_missing = create_if_missing

---Returns a decoded lockfile read and parsed from the given path
---@param lockfile_path string? Optional path to the lockfile
---@return table<string, string?>
local read_lockfile = function(lockfile_path)
  return vim.fn.json_decode(vim.fn.readfile(lockfile_path or M.lockfile_path))
end
M.read_lockfile = read_lockfile

---Writes an encoded lockfile to the given path
---@param lockfile_path string? Optional path to the lockfile
local write_lockfile = function(lockfile_path)
  if lockfile_path == nil then
    lockfile_path = M.lockfile_path
  end

  local current_lockfile
  if lockfile_exists(lockfile_path) == 1 then
    current_lockfile = read_lockfile(lockfile_path)
  else
    current_lockfile = {}
  end

  local installed_pkgs = registry.get_installed_packages()

  local entries_tbl = {}
  for _, pkg in pairs(installed_pkgs) do
    -- Record current version of pkg
    entries_tbl[pkg.name] = pkg:get_installed_version()
    -- Remove pkg from current lockfile entries
    current_lockfile[pkg.name] = nil
  end

  -- Add all remaining lockfile entries that are not installed locally. The
  -- current system may have conditionally not installed some packages but
  -- these packages should still exist in the resulting lockfile.
  for lockfile_name, lockfile_version in pairs(current_lockfile) do
    entries_tbl[lockfile_name] = lockfile_version
  end

  write_lockfile_entries(lockfile_path, entries_tbl)
  info("Wrote Mason lockfile")
end
M.write_lockfile = write_lockfile

local lspconfig_mappings_cache

---Normalizes an lspconfig/dap tool or Mason package name to a Mason registry package name
---@param name string Packge name which could be an lspconfig name, a DAP name, or a Mason name
---@return string
local to_mason_registry_name = function(name)
  if not lspconfig_mappings_cache then
    lspconfig_mappings_cache = mlsp.get_mappings()
  end

  name = lspconfig_mappings_cache.lspconfig_to_package[name] or name
  name = mdap.nvim_dap_to_package[name] or name

  return name
end

---@class (exact) RestoreResult
---@field installed string[] Names of packages installed or updated
---@field failed string[] Names of packages that failed to install

---@class (exact) RestoreOpts
---@field verbose? boolean Whether or not to display notifications
---@field interactive? boolean Whether editor is interactive or headless
---@field lockfile_path? string Path to the lockfile
---@field on_done? fun(result: RestoreResult) Called once all installs have
---finished

---Installs packages using version information from the lockfile
---@param ensure_installed_list? string[] Optional list of package names to
---ensure are installed
---@param opts? RestoreOpts
local restore = function(ensure_installed_list, opts)
  opts = opts or {}

  local lockfile_path = opts.lockfile_path or M.lockfile_path
  local verbose = opts.verbose ~= false
  local interactive = opts.interactive ~= false
  -- Scheduled so that it runs after any already-scheduled log output
  local on_done = vim.schedule_wrap(opts.on_done or function() end)

  ---@type RestoreResult
  local result = { installed = {}, failed = {} }

  -- If there is no lockfile, then early return
  if not lockfile_exists(lockfile_path) then
    if verbose then
      error("No lockfile found, no packages installed", interactive)
    end
    on_done(result)
    return
  end

  local lockfile = read_lockfile(lockfile_path)

  local pkgs_to_check
  if ensure_installed_list == nil then
    -- By default, use the list of packages in the lockfile
    pkgs_to_check = table_ext.map_to_list(lockfile, function(key, _)
      return key
    end)
  else
    -- If a custom list of packages is provided, use it, ensuring that all
    -- names are Mason registry package names
    pkgs_to_check = table_ext.map_list_to_list(ensure_installed_list, function(name)
      return to_mason_registry_name(name)
    end)
  end

  ---Installs the given packages, then reports the result
  ---@param packages_to_install { pkg: Package, version: string?, name: string }[]
  local install_packages = function(packages_to_install)
    if #packages_to_install == 0 then
      if verbose and #result.failed == 0 then
        info("All installed package versions set from lockfile", interactive)
        if interactive then
          close_ui()
        end
      end
      on_done(result)
      return
    end

    if verbose and interactive then
      require("mason.ui").open()
    end

    info(
      string.format("Installing or updating %d Mason packages", #packages_to_install),
      interactive
    )

    local remaining = #packages_to_install
    local finish = function(item, success, err)
      if success then
        table.insert(result.installed, item.name)
        if verbose then
          info(("Installed %s@%s"):format(item.name, item.version or "latest"), interactive)
        end
      else
        table.insert(result.failed, item.name)
        error(("Failed to install %s: %s"):format(item.name, tostring(err)), interactive)
      end

      remaining = remaining - 1
      if remaining == 0 then
        if verbose then
          if #result.failed == 0 then
            info("Mason packages restored to lockfile versions", interactive)
          end
          if interactive then
            close_ui()
          end
        end
        on_done(result)
      end
    end

    for _, item in ipairs(packages_to_install) do
      -- `install` asserts if the package is already installing
      local started, install_err = pcall(function()
        item.pkg:install({ version = item.version }, function(success, err)
          finish(item, success, err)
        end)
      end)
      if not started then
        finish(item, false, install_err)
      end
    end
  end

  -- Refresh registry to ensure we have latest info. This may complete
  -- asynchronously, so all further work happens in the callback.
  registry.refresh(function(refreshed, refresh_err)
    local packages_to_install = {}
    local unknown_pkgs = {}

    for _, pkg_name in pairs(pkgs_to_check) do
      local locked_version = lockfile[pkg_name]

      local ok, pkg = pcall(registry.get_package, pkg_name)
      if ok then
        if not pkg:is_installed() then
          -- Package not installed, needs installation
          table.insert(
            packages_to_install,
            { pkg = pkg, version = locked_version, name = pkg_name }
          )
        else
          local receipt = pkg:get_receipt():or_else({})
          local current_version = receipt.install_options and receipt.install_options.version

          if current_version ~= locked_version then
            -- Version mismatch, needs to reinstall
            table.insert(
              packages_to_install,
              { pkg = pkg, version = locked_version, name = pkg_name }
            )
          end
        end
      else
        table.insert(unknown_pkgs, pkg_name)
      end
    end

    -- Registry callbacks may run in a fast event context
    vim.schedule(function()
      if not refreshed then
        error("Failed to refresh Mason registry: " .. tostring(refresh_err), interactive)
      end
      -- Packages missing from the registry can never be installed, so fail rather than skip them
      for _, pkg_name in ipairs(unknown_pkgs) do
        table.insert(result.failed, pkg_name)
        error(("Package %s not found in Mason registry"):format(pkg_name), interactive)
      end
      install_packages(packages_to_install)
    end)
  end)
end
M.restore = restore

local setup = function(cfg)
  if cfg and cfg.lockfile_path then
    M.lockfile_path = cfg.lockfile_path
  end

  create_if_missing()
end
M.setup = setup

return M
