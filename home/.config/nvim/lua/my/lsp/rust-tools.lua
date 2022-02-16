local utils = require("my.utils")
local require_or_warn = utils.require_or_warn
local notify = utils.notify

local rust_tools_ok, rust_tools = require_or_warn("rust-tools")
if not rust_tools_ok then
  return
end

local di_ok, di = require_or_warn("dap-install.api.debuggers")
if not di_ok then
  return
end

local ok, lspconfig = require_or_warn("lspconfig")
if not ok then
  return
end
local path = lspconfig.util.path

M = {}

-- Configuration references:
-- * https://github.com/simrat39/rust-tools.nvim/issues/114
-- * https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
M.setup = function(server, opts)
  local rust_tools_opts = {
    server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
  }

  -- Use and connfigure the CodeLLDB VSCode extension if it is installed
  -- See: https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
  if vim.tbl_contains(di.get_installed_debuggers(), "codelldb") then
    local sysname = vim.loop.os_uname().sysname
    local liblldb
    if sysname == "Linux" then
      liblldb = "liblldb.so"
    elseif sysname == "Darwin" then
      liblldb = "liblldb.dylib"
    else
      notify.error("unsupported codelldb platform: %s", sysname)
      return
    end
    local debugger_path_prefix = path.join(
      string.gsub(require("dap-install.config.settings").options["installation_path"], "/$", ""),
      "codelldb",
      "extension"
    )
    local codelldb_path = path.join(debugger_path_prefix, "adapter", "codelldb")
    local liblldb_path = path.join(debugger_path_prefix, "lldb", "lib", liblldb)

    if not path.is_file(codelldb_path) then
      notify.error("codelldb is installed, but program cannot be found: %s", codelldb_path)
      return
    end
    if not path.is_file(liblldb_path) then
      notify.error("codelldb is installed, but library cannot be found: %s", liblldb_path)
      return
    end

    rust_tools_opts["dap"] = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    }
  end

  rust_tools.setup(rust_tools_opts)
  server:attach_buffers()
end

return M
