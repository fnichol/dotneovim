-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer

-- Default options for all projects
local default_opts = {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        -- Favor `cargo clippy` to `cargo check` for diagnostics
        command = "clippy",
      },
    },
  },
}

-- VSCode settings key to look for an use if found
local vscode_settings_key = "rust-analyzer"

local utils = require("my.utils")
local notify = utils.notify
local require_or_warn = utils.require_or_warn

local ok, lspconfig = require_or_warn("lspconfig")
if not ok then
  return
end

-- https://github.com/tamago324/nlsp-settings.nvim/blob/main/lua/nlspsettings.lua

local json_to_table = function(t)
  vim.validate({ t = { t, "t" } })

  local res = {}

  for key, value in pairs(t) do
    local key_list = {}

    for k in string.gmatch(key, "([^.]+)") do
      table.insert(key_list, k)
    end

    local tbl = res
    for i, k in ipairs(key_list) do
      if i == #key_list then
        tbl[k] = value
      end
      if tbl[k] == nil then
        tbl[k] = {}
      end
      tbl = tbl[k]
    end
  end

  return res
end

local json_decode = function(data)
  local decode_ok, result = pcall(vim.fn.json_decode, data)
  if decode_ok then
    return result
  else
    return nil, result
  end
end

local load = function(path)
  vim.validate({ path = { path, "s" } })

  local decoded, err = json_decode(vim.fn.readfile(path))
  if err ~= nil then
    return {}, true
  end
  if decoded == nil then
    return {}
  end

  return json_to_table(decoded) or {}
end

-- Determine candidate path for a local VSCode configuration file
local root_dir = lspconfig.util.root_pattern(".vscode", ".git", "Cargo.lock")(vim.fn.getcwd())
local project_settings_json = lspconfig.util.path.join(root_dir, ".vscode", "settings.json")

-- Load and parse a local VSCode confiruation if found
local project_settings = {}
if lspconfig.util.path.is_file(project_settings_json) then
  local loaded, err = load(project_settings_json)
  if err then
    notify.error("failed to load local settings '%s\n\n%s", project_settings_json, err)
    return
  end
  project_settings = loaded
end

-- Filter the VSCode configuration to only the desired table key
local project_opts = { settings = {} }
if project_settings[vscode_settings_key] ~= nil then
  project_opts["settings"][vscode_settings_key] = project_settings[vscode_settings_key]
end

-- Merge any local confiruation with the defaults, favoring the local opts
local opts = vim.tbl_deep_extend("force", project_opts, default_opts)
return opts
