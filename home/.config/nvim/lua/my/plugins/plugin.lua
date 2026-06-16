---Restores plugins and packages from lock files
---@param cmd vim.api.keyset.create_user_command.command_args
local install_plugins = function(cmd)
  local interactive = cmd.bang ~= true

  -- Lazy.nvim plugins
  --
  require("lazy").restore({ wait = true })
  if interactive then
    require("lazy.view").view:close()
  end

  --- Mason packages
  ---
  if interactive then
    require("mason.ui").open()
  end
  require("mason-lock").restore(
    require("my.util.mason").ensure_installed_list(),
    { interactive = interactive }
  )
end

local update_plugins = function()
  -- Lazy.nvim plugins
  --

  require("lazy").update({ wait = true })
  require("lazy.view").view:close()

  --- Mason packages
  ---

  -- Wait until `MasonToolsUpdateCompleted` event has fired, then write lockfile and close UI
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
    -- Can be used with `nvim --headless +PluginInstall! +qall`
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
