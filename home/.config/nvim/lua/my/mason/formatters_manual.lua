M = {}

local sys = require("my.util.sys")

local configuration = {
  -- The Uncompromising Nix Code Formatter.
  --
  -- https://kamadorueda.com/alejandra/
  alejandra = {
    -- If executable is not present, prevent the formatter from activating
    use_condition = function()
      return sys.has_executable("alejandra")
    end,
  },
  -- Formats HCL2 configuration files to a canonical format and style.
  --
  -- https://developer.hashicorp.com/packer/docs/commands/fmt
  packer = {
    -- If executable is not present, prevent the formatter from activating
    use_condition = function()
      return sys.has_executable("packer")
    end,
  },
  -- A tool for formatting rust code according to style guidelines.
  --
  -- https://github.com/rust-lang/rustfmt
  rustfmt = {},
}

local by_filetype = {
  nix = {
    "alejandra",
    -- If executable is not present, prevent the formatter from activating
    use_condition = function()
      return sys.has_executable("alejandra")
    end,
  },
  hcl = {
    "packer_fmt",
    -- If executable is not present, prevent the formatter from activating
    use_condition = function()
      return sys.has_executable("packer")
    end,
  },
  rust = { "rustfmt" },
}

local table = require("my.util.table")

M.configuration = function()
  return table.filter_use_table(configuration)
end
M.by_filetype = function()
  return table.filter_use_table(by_filetype)
end

return M
