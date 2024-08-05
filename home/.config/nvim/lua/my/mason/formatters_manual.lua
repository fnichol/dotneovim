M = {}

local configuration = {
  -- The Uncompromising Nix Code Formatter.
  --
  -- https://kamadorueda.com/alejandra/
  alejandra = {},
  -- Formats HCL2 configuration files to a canonical format and style.
  --
  -- https://developer.hashicorp.com/packer/docs/commands/fmt
  packer = {},
  -- A tool for formatting rust code according to style guidelines.
  --
  -- https://github.com/rust-lang/rustfmt
  rustfmt = {},
}

local by_filetype = {
  nix = { "alejandra" },
  hcl = { "packer_fmt" },
  rust = { "rustfmt" },
}

-- If `alejandra` is not present, prevent the formatter from activating
if vim.fn.executable("alejandra") ~= 1 then
  configuration["alejandra"] = nil

  by_filetype["nix"] = nil
end

-- If `packer` is not present, prevent the formatter from activating
if vim.fn.executable("packer") ~= 1 then
  configuration["packer"] = nil

  by_filetype["hcl"] = nil
end

M.configuration = configuration
M.by_filetype = by_filetype

return M
