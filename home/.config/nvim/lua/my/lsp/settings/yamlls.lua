-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls

return {
  settings = {
    yaml = {
      -- TODO: remove on next release (post-1.12.0) when default for this setting is `false`
      --
      -- Reference: https://github.com/redhat-developer/yaml-language-server/pull/859
      keyOrdering = false,
    },
  },
}
