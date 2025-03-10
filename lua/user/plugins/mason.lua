return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local mason_tool_installer = require 'mason-tool-installer'

    mason.setup {}

    mason_lspconfig.setup {
      ensure_installed = {
        'ts_ls',
        'html',
        'intelephense',
        'gopls',
        'tailwindcss',
        'htmx',
        'nil_ls',
        'emmet_language_server',
        'graphql',
        'elmls',
        'erlangls',
        'eslint',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettier',
        'isort',
        'eslint_d',
        'pretty-php',
        'elm-format',
        'sql-formatter',
        'sqlfmt',
      },
    }
  end,
}
