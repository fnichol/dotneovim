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
    vim.notify("[my.packer] failed to require 'packer'", WARN)
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
    vim.notify("[my.packer] skipping loading plugins until packer is installed", ERROR)
    return
  end

  local status_ok, _ = xpcall(function()
    packer.startup(plugins)
  end, debug.traceback)
  if not status_ok then
    vim.notify("[my.packer] problems detected while loading plugins", ERROR)
  end

  if PACKER_INSTALLED then
    require("packer").sync()
  end
end

return M
