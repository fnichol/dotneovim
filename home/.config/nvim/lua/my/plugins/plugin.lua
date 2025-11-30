local function close_mason_ui()
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

local function restore_mason_from_lockfile()
  local registry = require("mason-registry")

  -- Read mason-lock.json
  local lockfile_path = vim.fs.joinpath(vim.fn.stdpath("config"), "mason-lock.json")
  local lockfile = vim.fn.json_decode(vim.fn.readfile(lockfile_path))

  local packages_to_install = {}

  -- Refresh registry to ensure we have latest info
  registry.refresh(function()
    for pkg_name, locked_version in pairs(lockfile) do
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
      end
    end
  end)

  -- Install/update packages that need aren't in sync with the lock file
  if #packages_to_install > 0 then
    vim.cmd("Mason")

    vim.notify(
      string.format("Installing / updating %d Mason packages", #packages_to_install),
      vim.log.levels.INFO
    )

    local handles = {}
    for _, item in ipairs(packages_to_install) do
      local handle = item.pkg:install({ version = item.version })
      table.insert(handles, handle)
    end

    -- Wait for completion then close Mason UI
    local completed = 0
    for _, handle in ipairs(handles) do
      handle:on("closed", function()
        completed = completed + 1
        if completed == #handles then
          vim.notify("Mason packages restored to lock file versions", vim.log.levels.INFO)
          close_mason_ui()
        end
      end)
    end
  else
    vim.notify("All installed Mason packages are current with the lock file", vim.log.levels.INFO)
  end
end

return {
  name = "plugin-commands",
  dir = vim.fn.stdpath("config"),
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_user_command("PluginInstall", function()
      require("lazy").restore({ wait = true })
      require("lazy.view").view:close()

      restore_mason_from_lockfile()
    end, { desc = "Restore plugins and packages from lock files" })

    vim.api.nvim_create_user_command("PluginUpdate", function()
      require("lazy").update({ wait = true })
      require("lazy.view").view:close()

      -- Create one-time autocmd to handle Mason completion
      local group = vim.api.nvim_create_augroup("PluginUpdateMason", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        group = group,
        once = true,
        callback = function()
          -- Update the lock file
          vim.cmd("MasonLock")
          -- Close Mason UI
          close_mason_ui()
        end,
      })

      vim.cmd("Mason")
      vim.cmd("MasonToolsUpdate")
    end, { desc = "Update plugins and packages, then update lock files" })
  end,
}
