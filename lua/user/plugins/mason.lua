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
        'html',
        'intelephense',
        'phpactor',
        'gopls',
        'tailwindcss',
        'htmx',
        'nil_ls',
        'emmet_language_server',
        'graphql',
        'elmls',
        'erlangls',
        'astro',
        'vue_ls',
        'vtsls',
        'glsl_analyzer',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'eslint_d',
        'prettierd',
        'isort',
        'pretty-php',
        'elm-format',
        'sql-formatter',
        'sqlfmt',
        'php-cs-fixer',
        'php-debug-adapter',
        'phpstan',
        'yamlfmt',
      },
    }
  end,
}
