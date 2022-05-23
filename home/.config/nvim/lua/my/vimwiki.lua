local utils = require("my.utils")
local require_or_warn = utils.require_or_warn

local ok, which_key = require_or_warn("which-key")
if not ok then
  return
end

local common_config = {
  -- Use Markdown syntax
  syntax = "markdown",
  -- Use `.md` as the wiki file extension
  ext = ".md",
  -- Use dashes for spaces when creating a new file from a link
  links_space_char = "-",
  -- Update the table of contents section when the current page is saved
  auto_toc = 1,
  -- Update the diary index when opened
  auto_diary_index = 1,
  -- Name of the wiki page to be used for the Diary index (found in `diary/`)
  diary_index = "index",
  -- Set list of files to be excluded when checking or generating links
  exclude_files = { "**/README.md" },
}

local function copy_table(table)
  local table2 = {}
  for key, value in pairs(table) do
    table2[key] = value
  end
  return table2
end

-- Setup the default 'brain' wiki
local brain_wiki = copy_table(common_config)
brain_wiki.path = "~/Documents/wikis/brain/content"

-- Setup the public 'knowledge' wiki
local knowledge_wiki = copy_table(common_config)
knowledge_wiki.path = "~/Documents/wikis/knowledge/content"

-- Register the default wiki
vim.g.vimwiki_list = { brain_wiki, knowledge_wiki }
-- Disable vimwiki mode for non-wiki markdown buffers
vim.g.vimwiki_global_ext = 0
-- Generate a header when creating a new wiki page
vim.g.vimwiki_auto_header = 1
-- Interpret a link of `dir/` as `dir/index.md`
vim.g.vimwiki_dir_link = "index"
-- Set auto-numbering in HTML, starting from header level 2
vim.g.vimwiki_html_header_numbering = 2
-- Add a dot after the header's number
vim.g.vimwiki_html_header_numbering_sym = "."
-- The magic header name for a table of contents section
vim.g.vimwiki_toc_header = "Table of Contents"
-- Set the header level of the table of contents section to 2
vim.g.vimwiki_toc_header_level = 2
-- Set the header level of the generated links section to 2
vim.g.vimwiki_links_header_level = 2
-- Set the header level of the tags section to 2
vim.g.vimwiki_tags_header_level = 2

which_key.register({
  w = {
    name = "VimWiki",
    w = { "<cmd>VimwikiIndex<CR>", "Open default wiki index file" },
    t = { "<cmd>VimwikiIndex<CR>", "Open default wiki index file in a new tab" },
    s = { "<cmd>VimwikiIndex<CR>", "Select and open wiki index file" },
    d = { "<cmd>VimwikiIndex<CR>", "Delete current wiki file" },
    r = { "<cmd>VimwikiIndex<CR>", "Rename current wiki file" },
  },
}, { buffer = 0, prefix = "<leader>" })
