local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

local rust_tools_ok, rust_tools = require_or_warn("rust-tools")
if not rust_tools_ok then
  return
end

local wk_ok, which_key = require_or_warn("which-key")
if not wk_ok then
  return
end

-- Usage: https://github.com/simrat39/rust-tools.nvim

local mappings = {
  [""] = {
    -- Replace the stock LSP hover with rust-tool's expanded hover info and
    -- actions
    K = {
      "<cmd>lua require('rust-tools').hover_actions.hover_actions()<CR>",
      "Show Hover Documentation (LSP)",
    },
  },
  ["<leader>"] = {
    -- Add bindings to LSP section
    l = {
      E = {
        "<cmd>lua require('rust-tools').expand_macro.expand_macro()<CR>",
        "Expand Macro (Rust)",
      },
      R = {
        "<cmd>lua require('rust-tools').runnables.runnables()<CR>",
        "Runnables (Rust)",
      },
    },
    R = {
      name = "Rust",
      h = {
        "<cmd>lua require('rust-tools').hover_actions.hover_actions()<CR>",
        "Show Hover Documentation and Actions",
      },
      i = {
        name = "Inlay Hints",
        d = {
          "<cmd>lua require('rust-tools').inlay_hints.disable()<CR>",
          "Disable all buffers",
        },
        e = {
          "<cmd>lua require('rust-tools').inlay_hints.enable()<CR>",
          "Enable all buffers",
        },
        s = {
          "<cmd>lua require('rust-tools').inlay_hints.set()<CR>",
          "Set for current buffer",
        },
        u = {
          "<cmd>lua require('rust-tools').inlay_hints.unset()<CR>",
          "Unset for current buffer",
        },
      },
      e = {
        "<cmd>lua require('rust-tools').expand_macro.expand_macro()<CR>",
        "Expand Macro",
      },
      r = {
        "<cmd>lua require('rust-tools').runnables.runnables()<CR>",
        "Runnables",
      },
      s = {
        "<cmd>lua require('rust-tools').ssr.ssr()<CR>",
        "Structural Search Replace",
      },
    },
  },
  ["g"] = {
    C = {
      "<cmd>lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>",
      "Open Cargo.toml",
    },
    p = {
      "<cmd>lua require('rust-tools.parent_module').parent_module()<CR>",
      "Goto Parent Module",
    },
  },
}

M = {}

local function lsp_key_mappings(bufnr)
  for prefix, buffer_mappings in pairs(mappings) do
    which_key.register(buffer_mappings, { prefix = prefix, buffer = bufnr })
  end
end

M.setup = function(server_options)
  local rust_analyzer_server_options = server_options or {}
  local common_on_attach = rust_analyzer_server_options.on_attach

  rust_analyzer_server_options.on_attach = function(client, bufnr)
    if common_on_attach then
      common_on_attach(client, bufnr)
    end
    lsp_key_mappings(bufnr)
  end

  local rust_tools_options = {
    server = rust_analyzer_server_options,
  }

  rust_tools.setup(rust_tools_options)
end

return M
