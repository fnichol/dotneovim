local M = {}

function M.ensure_installed()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    -- Install packer if missing
    print("[my.packer] Installing packer.nvim…")
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    print("[my.packer] Packer installed")

    return true
  else
    return false
  end
end

return M
