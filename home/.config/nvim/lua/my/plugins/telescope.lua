local telescope_fzf_native_build = "make"
if vim.uv.os_uname().sysname == "OpenBSD" then
  telescope_fzf_native_build = "gmake"
end

return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  --
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      -- full; complete; entire; absolute; unqualified. All the lua functions I
      -- don't want to write twice.
      --
      -- https://github.com/nvim-lua/plenary.nvim
      { "nvim-lua/plenary.nvim" },
      -- FZF sorter for telescope written in c
      --
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      {
        "nvim-telescope/telescope-fzf-native.nvim",
	build = telescope_fzf_native_build,
	cond = function()
          return vim.fn.executable(telescope_fzf_native_build) == 1
	end,
      },
      -- It sets vim.ui.select to telescope.
      --
      -- https://github.com/nvim-telescope/telescope-ui-select.nvim
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Lua fork of vim-web-devicons for NeoVim
      --
      -- https://github.com/nvim-tree/nvim-web-devicons
      {
        "nvim-tree/nvim-web-devicons",
	enabled = vim.g.have_nerd_font,
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local telescope_setup = {
        defaults = {},
        pickers = {},
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }
      -- Prefer `ripgrep` if available and traverse hidden files/directories
      if vim.fn.executable("rg") == 1 then
        telescope_setup.defaults.vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        }
      end
      -- Prefer `fd` if available
      if vim.fn.executable("fd") == 1 then
        telescope_setup.pickers["find_files"] = {
          find_command = {
            "fd",
            "--type=file",
            "--hidden",
            "--exclude=.git",
            "--follow",
            "--strip-cwd-prefix",
          },
        }
      end

      require("telescope").setup(telescope_setup)

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See: `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffer" })
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find File" })
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Checkout Branch (Git)" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Checkout Commit (Git)" })
      vim.keymap.set("n", "<leader>go", builtin.git_status, { desc = "Open Changed File (Git)" })
      vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "Colorscheme" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostic" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymap" })
      vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "Man Page" })
      vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "Recent File" })
      vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Text" })

      vim.keymap.set(
        "n",
        "<leader>/",
        function()
          builtin.current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            })
          )
        end,
        { desc = "Fuzzily search in current buffer" }
      )
    end,
  },
}
