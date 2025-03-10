return {
  'luckasRanarison/tailwind-tools.nvim',
  enabled = true,
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {
    server = {
      override = false,
    },
    extensions = {
      patterns = { gleam = { 'class%("[^"]+)"%)' } },
    },
  }, -- your configuration
}
