return {
  -- A UI for nvim-dap
  --
  -- https://github.com/rcarriga/nvim-dap-ui
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      -- A library for asynchronous IO in Neovim
      --
      -- https://github.com/nvim-neotest/nvim-nio
      { "nvim-neotest/nvim-nio" },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
  },
  -- Debug Adapter Protocol client implementation for Neovim
  --
  -- https://github.com/mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "williamboman/mason.nvim", config = true },
      -- Adds virtual text support to nvim-dap. nvim-treesitter is used to find
      -- variable definitions
      --
      -- https://github.com/theHamsta/nvim-dap-virtual-text
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      vim.fn.sign_define("DapStopped", {
        text = "󰁕 ",
        texthl = "DiagnosticWarn",
        linehl = "DapStoppedLine",
        numhl = "DapStoppedLine",
      })
      vim.fn.sign_define("DapBreakpoint", {
        text = " ",
        texthl = "DiagnosticInfo",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = " ",
        texthl = "DiagnosticInfo",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = " ",
        texthl = "DiagnosticError",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = ".>",
        texthl = "DiagnosticInfo",
      })

      local dap = require("dap")
      local has_mason, mason_registry = pcall(require, "mason-registry")
      if not has_mason then
        require("my.util.notify").error("Mason could not not be loaded")
        return
      end
      local daps = require("my.mason.daps")

      dap.adapters = vim.tbl_deep_extend(
        "force",
        {},
        dap.adapters,
        daps.configuration.bash.adapters(mason_registry),
        daps.configuration.codelldb.adapters(mason_registry)
      )
      dap.configurations = vim.tbl_deep_extend(
        "force",
        {},
        dap.configurations,
        daps.configuration.bash.configurations(mason_registry),
        daps.configuration.codelldb.configurations(mason_registry)
      )
    end,
    keys = {
      {
        "<leader>da",
        function()
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to Line (No Execute)",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").down()
        end,
        desc = "Up",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle Repl",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dw",
        function()
          require("daplui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },
  },
  -- An extension for nvim-dap, providing default configurations for python and
  -- methods to debug individual test methods or classes.
  --
  -- https://github.com/mfussenegger/nvim-dap-python
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },
    },
    config = function()
      local path_prefix = vim.fs.joinpath(vim.fn.expand("$MASON"), "packages", "debugpy", "venv")

      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(vim.fs.joinpath(path_prefix, "Scripts", "pythonw.exe"))
      else
        require("dap-python").setup(vim.fs.joinpath(path_prefix, "bin", "python"))
      end
    end,
  },
  -- An extension for nvim-dap providing configurations for launching go
  -- debugger (delve) and debugging individual tests
  --
  -- https://github.com/leoluz/nvim-dap-go
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },
    },
    opts = {},
  },
}
