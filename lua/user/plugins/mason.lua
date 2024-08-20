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
        'tsserver',
        'html',
        'intelephense',
        'gopls',
        'tailwindcss',
        'htmx',
        'nil_ls',
        'emmet_language_server',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettier',
        'isort',
        'eslint_d',
        'pretty-php',
        'elm-format',
      },
    }
  end,
}
