local M = {}

function M:init()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  -- Install packer if missing
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("[packer] Installing…")
    PACKER_INSTALLED = vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    print("[packer] Installation complete.")
  end

  local ok, packer = pcall(require, "packer")
  if not ok then
    return
  end
  packer.init({
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  })

  return self
end

function M.load(plugins)
  local packer_available, packer = pcall(require, "packer")
  if not packer_available then
    vim.cmd("echohl ErrorMsg")
    vim.cmd('echom "[packer] Skipping loading plugins until packer is installed"')
    vim.cmd("echohl None")
    return
  end

  local status_ok, _ = xpcall(function()
    packer.startup(function(use)
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end)
  end, debug.traceback)
  if not status_ok then
    vim.cmd("echohl WarnMsg")
    vim.cmd('echom "[packer] Problems detected while loading plugins"')
    vim.cmd("echohl None")
  end

  if PACKER_INSTALLED then
    require("packer").sync()
  end
end

return M
