M = {}

-- https://mason-registry.dev/registry/list?search=category%3Adap
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua

local configuration = {
  -- Bash shell debugger extension for VSCode (based on bashdb)
  --
  -- https://github.com/rogalmic/vscode-bash-debug
  bash = {
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#bash
    adapters = function(mason_registry)
      local pkg_path = mason_registry.get_package("bash-debug-adapter"):get_install_path()

      return {
        bashdb = {
          type = "executable",
          command = vim.fs.joinpath(pkg_path, "bash-debug-adapter"),
          name = "bashdb",
        },
      }
    end,
    configurations = function(mason_registry)
      local pkg_path = mason_registry.get_package("bash-debug-adapter"):get_install_path()

      return {
        sh = {
          {
            type = "bashdb",
            request = "launch",
            name = "Launch file",
            showDebugOutput = true,
            pathBashdb = vim.fs.joinpath(pkg_path, "extension", "bashdb_dir", "bashdb"),
            pathBashdbLib = vim.fs.joinpath(pkg_path, "extension", "bashdb_dir"),
            trace = true,
            file = "${file}",
            program = "${file}",
            cwd = "${workspaceFolder}",
            pathCat = "cat",
            pathBash = "bash",
            pathMkfifo = "mkfifo",
            pathPkill = "pkill",
            args = {},
            env = {},
            terminalKind = "integrated",
          },
        },
      }
    end,
  },
  -- A native debugger extension for VSCode based on LLDB
  --
  -- https://github.com/vadimcn/vscode-lldb
  codelldb = {
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-codelldb
    -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
    adapters = function(mason_registry)
      local pkg_path = mason_registry.get_package("codelldb"):get_install_path()

      return {
        codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fs.joinpath(pkg_path, "extension", "adapter", "codelldb"),
            args = { "--port", "${port}" },
          },
        },
      }
    end,
    configurations = function(_)
      local configuration = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      return {
        cpp = configuration,
        c = configuration,
        rust = configuration,
      }
    end,
  },
  -- Delve is a debugger for the Go programming language.
  --
  -- https://github.com/go-delve/delve
  delve = {
    -- Managed via `nvim-dap-go`
    --
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
  },
  -- An implementation of the Debug Adapter Protocol for Python
  --
  -- https://github.com/microsoft/debugpy
  python = {
    -- Managed via `nvim-dap-python`
    --
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
  },
}

M.configuration = configuration

return M
