local install_plugins = function()
  -- Lazy.nvim plugins
  --

  require("lazy").restore({ wait = true })
  require("lazy.view").view:close()

  --- Mason packages
  ---

  require("mason.ui").open()
  require("mason-lock").restore(require("my.util.mason").ensure_installed_list())
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
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_user_command(
      "PluginInstall",
      install_plugins,
      { desc = "Restore plugins and packages from lock files" }
    )

    vim.api.nvim_create_user_command(
      "PluginUpdate",
      update_plugins,
      { desc = "Update plugins and packages, then update lock files" }
    )
  end,
}
