return {
  -- Smart and powerful comment plugin for Neovim.
  --
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    dependencies = {
      -- Neovim treesitter plugin for setting the commentstring based on the
      -- cursor location in a file.
      --
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
        },
      },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring"
            and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
}
